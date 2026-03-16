import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';
import 'package:dopi_game/l10n/app_localizations.dart';

import '../../../../core/constants/app_constants.dart';
import '../bloc/gamification_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final l10n = AppLocalizations.of(context)!;
    
    // Request permission based on source
    if (source == ImageSource.camera) {
      final status = await Permission.camera.request();
      if (!status.isGranted) {
        _showPermissionDenied(context, l10n);
        return;
      }
    } else {
      // Gallery permission depends on Android version (Storage or Photos/Images)
      if (Platform.isAndroid) {
        if (await Permission.photos.request().isGranted || await Permission.storage.request().isGranted) {
            // Permission granted
        } else {
            _showPermissionDenied(context, l10n);
            return;
        }
      }
    }

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      // Save the file locally so it persists app restarts (cache files might get deleted)
      // We append a timestamp to the filename to ensure Flutter's ImageCache reloads it properly.
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = '${DateTime.now().millisecondsSinceEpoch}_${p.basename(pickedFile.path)}';
      final savedImagePath = p.join(appDir.path, fileName);
      final file = File(pickedFile.path);
      await file.copy(savedImagePath);

      // ignore: use_build_context_synchronously
      context.read<GamificationBloc>().add(UpdateAvatarEvent(savedImagePath));
    }
  }

  void _showPermissionDenied(BuildContext context, AppLocalizations l10n) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.permissionDenied)),
    );
  }

  void _showImageSourceDialog(BuildContext context, AppLocalizations l10n) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppConstants.borderRadiusCozy)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: Text(l10n.camera),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(context, ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text(l10n.gallery),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(context, ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(l10n.profileTitle, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
      ),
      body: BlocBuilder<GamificationBloc, GamificationState>(
        builder: (context, state) {
          if (state is GamificationLoaded) {
            final stats = state.userStats;
            ImageProvider? avatarImage;
            
            if (stats.avatarPath != null && stats.avatarPath!.isNotEmpty) {
               final file = File(stats.avatarPath!);
               if(file.existsSync()){
                 avatarImage = FileImage(file);
               }
            }

            return OrientationBuilder(
              builder: (context, orientation) {
                final bool isLandscape = orientation == Orientation.landscape;
                
                final avatarWidget = Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: isLandscape ? 50 : 60,
                        backgroundColor: theme.colorScheme.secondary.withOpacity(0.5),
                        backgroundImage: avatarImage,
                        child: avatarImage == null
                            ? Icon(Icons.person, size: isLandscape ? 50 : 60, color: Colors.white)
                            : null,
                      ),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: theme.colorScheme.primary,
                        child: IconButton(
                          icon: const Icon(Icons.add_a_photo, size: 20, color: Colors.white),
                          onPressed: () => _showImageSourceDialog(context, l10n),
                        ),
                      ),
                    ],
                  ),
                );

                final nameWidget = Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppConstants.paddingMedium),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            stats.username,
                            style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit, size: 20),
                            onPressed: () => _showEditNameDialog(context, stats.username, l10n),
                          ),
                        ],
                      ),
                    ],
                  ),
                );

                final statsWidget = Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.paddingLarge),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildStatRow(theme, Icons.star, l10n.statsLevel(stats.currentLevel), stats.currentLevel.toString()),
                        const Divider(height: 32),
                        _buildStatRow(theme, Icons.trending_up, l10n.totalXp, stats.currentXp.toString()),
                        const Divider(height: 32),
                        _buildStatRow(theme, Icons.task_alt, l10n.totalCompletedTasks, stats.totalCompletedTasks.toString()),
                      ],
                    ),
                  ),
                );


                if (isLandscape) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(AppConstants.paddingLarge),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1, 
                          child: Column(
                            children: [
                              avatarWidget,
                              nameWidget,
                            ],
                          ),
                        ),
                        const SizedBox(width: AppConstants.paddingLarge),
                        Expanded(flex: 2, child: statsWidget),
                      ],
                    ),
                  );
                }

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(AppConstants.paddingLarge),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      avatarWidget,
                      nameWidget,
                      const SizedBox(height: AppConstants.paddingLarge),
                      statsWidget,
                    ],
                  ),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  void _showEditNameDialog(BuildContext context, String currentName, AppLocalizations l10n) {
    final controller = TextEditingController(text: currentName);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.editName),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: l10n.usernameLabel,
            hintText: currentName,
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              final newName = controller.text.trim();
              if (newName.isNotEmpty) {
                context.read<GamificationBloc>().add(UpdateUsernameEvent(newName));
                Navigator.pop(context);
              }
            },
            child: Text(l10n.save),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(ThemeData theme, IconData icon, String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: theme.colorScheme.secondary),
            const SizedBox(width: AppConstants.paddingMedium),
            Text(title, style: theme.textTheme.titleMedium),
          ],
        ),
        Text(
          value,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
