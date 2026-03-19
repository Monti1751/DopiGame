import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../../core/constants/app_constants.dart';
import '../bloc/gamification_bloc.dart';
import '../widgets/task_card.dart';
import '../widgets/add_task_bottom_sheet.dart';
import 'settings_page.dart';
import 'profile_page.dart';
import 'package:confetti/confetti.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:dopi_game/l10n/app_localizations.dart';
import 'package:dopi_game/features/sanctuary/presentation/pages/sanctuary_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ConfettiController _confettiController;
  final AudioPlayer _audioPlayer = AudioPlayer();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    context.read<GamificationBloc>().add(LoadGamificationData());
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      context.read<GamificationBloc>().add(LoadMoreTasksEvent());
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _audioPlayer.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(l10n.appTitle, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        actions: [
          PopupMenuButton<int>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 0) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
              } else if (value == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Text(l10n.profileTitle),
              ),
              PopupMenuItem(
                value: 1,
                child: Text(l10n.settingsTitle),
              ),
            ],
          ),
        ],
      ),
      body: BlocConsumer<GamificationBloc, GamificationState>(
        listener: (context, state) {
          if (state is GamificationLoaded && state.showLevelUpAnimation) {
            _confettiController.play();
            _audioPlayer.play(UrlSource('https://www.myinstants.com/media/sounds/ff7-victory-fanfare.mp3'));
            
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l10n.levelUp(state.newLevel ?? 0)),
                backgroundColor: theme.colorScheme.secondary,
              ),
            );
            context.read<GamificationBloc>().add(CompleteTaskWithLevelUpAckEvent());
          }
        },
        builder: (context, state) {
          if (state is GamificationLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GamificationLoaded) {
            double targetXp = state.userStats.currentLevel * 100.0;
            double progress = (state.userStats.currentXp / targetXp).clamp(0.0, 1.0);

            return Stack(
              children: [
                Positioned.fill(
                  child: IgnorePointer(
                    child: Opacity(
                      opacity: 0.15,
                      child: Image.asset(
                        'assets/images/capybara_tea_party_background.png',
                        fit: BoxFit.cover,
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
                OrientationBuilder(
                  builder: (context, orientation) {
                    final bool isLandscape = orientation == Orientation.landscape;
                    
                    Widget content = Column(
                      children: [
                        _buildHeader(context, state.userStats.currentLevel, state.userStats.currentXp, progress, state.userStats.username, l10n, isLandscape: isLandscape),
                        Expanded(child: _buildTaskList(context, state, l10n)),
                      ],
                    );

                    if (isLandscape) {
                      return Row(
                        children: [
                          SizedBox(
                            width: 300,
                            child: _buildHeader(context, state.userStats.currentLevel, state.userStats.currentXp, progress, state.userStats.username, l10n, isLandscape: true),
                          ),
                          Expanded(child: _buildTaskList(context, state, l10n)),
                        ],
                      );
                    }
                    
                    return content;
                  },
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: ConfettiWidget(
                    confettiController: _confettiController,
                    blastDirectionality: BlastDirectionality.explosive,
                    shouldLoop: false,
                    colors: const [Colors.green, Colors.blue, Colors.pink, Colors.orange, Colors.purple],
                  ),
                ),
              ],
            );
          } else if (state is GamificationError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.paddingLarge),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.cloud_off, size: 80, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () => context.read<GamificationBloc>().add(LoadGamificationData()),
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reintentar'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: BlocBuilder<GamificationBloc, GamificationState>(
        builder: (context, state) {
          if (state is GamificationLoaded) {
            return FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => AddTaskBottomSheet(categories: state.categories),
                );
              },
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              child: const Icon(Icons.add),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildTaskList(BuildContext context, GamificationLoaded state, AppLocalizations l10n) {
    if (state.pendingTasks.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Container(
            padding: const EdgeInsets.all(AppConstants.paddingLarge),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface.withOpacity(0.8),
              borderRadius: BorderRadius.circular(AppConstants.borderRadiusCozy),
              border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.2), width: 2),
            ),
            child: Text(
              l10n.noTasks,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontStyle: FontStyle.italic),
            ),
          ),
        ),
      );
    }
    return ReorderableListView.builder(
      scrollController: _scrollController,
      onReorder: (oldIndex, newIndex) {
        if (newIndex > oldIndex) newIndex -= 1;
        context.read<GamificationBloc>().add(ReorderTaskEvent(oldIndex, newIndex));
      },
      itemCount: state.pendingTasks.length + (state.hasReachedMax ? 0 : 1),
      itemBuilder: (context, index) {
        if (index >= state.pendingTasks.length) {
          return const Center(key: ValueKey('loading_more'), child: Padding(padding: EdgeInsets.symmetric(vertical: 24.0), child: CircularProgressIndicator()));
        }
        final task = state.pendingTasks[index];
        return TaskCard(
          key: ValueKey(task.id),
          task: task,
          index: index,
          onComplete: () => context.read<GamificationBloc>().add(CompleteTaskEvent(task)),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, int level, int xp, double progress, String username, AppLocalizations l10n, {bool isLandscape = false}) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingLarge),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withOpacity(0.3),
        borderRadius: isLandscape 
          ? const BorderRadius.only(topRight: Radius.circular(AppConstants.borderRadiusCozy), bottomRight: Radius.circular(AppConstants.borderRadiusCozy))
          : const BorderRadius.only(bottomLeft: Radius.circular(AppConstants.borderRadiusCozy), bottomRight: Radius.circular(AppConstants.borderRadiusCozy)),
      ),
      height: isLandscape ? double.infinity : null,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: isLandscape ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            Text(
              "${l10n.welcomeMessage.split('!').first} $username!",
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  l10n.statsLevel(level),
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.orange.shade800,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.pets, color: Colors.white, size: 24),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SanctuaryPage()),
                      );
                    },
                    tooltip: 'Santuario',
                  ),
                ),
                const Spacer(),
                BlocBuilder<GamificationBloc, GamificationState>(
                  builder: (context, state) {
                    ImageProvider? avatarImage;
                    if (state is GamificationLoaded) {
                      final stats = state.userStats;
                      if (stats.avatarPath != null && stats.avatarPath!.isNotEmpty) {
                        final file = File(stats.avatarPath!);
                        if (file.existsSync()) avatarImage = FileImage(file);
                      }
                    }
                    return CircleAvatar(
                      backgroundColor: theme.colorScheme.secondary,
                      radius: 24,
                      backgroundImage: avatarImage,
                      child: avatarImage == null ? const Icon(Icons.person, color: Colors.white, size: 30) : null,
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: AppConstants.paddingMedium),
            Text(l10n.statsProgress, style: theme.textTheme.bodyMedium),
            const SizedBox(height: AppConstants.paddingSmall),
            LinearPercentIndicator(
              lineHeight: 14.0,
              percent: progress,
              backgroundColor: Colors.white,
              progressColor: theme.colorScheme.primary,
              barRadius: const Radius.circular(AppConstants.borderRadiusCozy),
            ),
          ],
        ),
      ),
    );
  }
}
