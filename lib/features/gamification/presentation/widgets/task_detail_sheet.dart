import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:dopi_game/l10n/app_localizations.dart';

import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/task.dart';
import '../bloc/gamification_bloc.dart';
import 'add_task_bottom_sheet.dart';

class TaskDetailSheet extends StatelessWidget {
  final TaskEntity task;

  const TaskDetailSheet({Key? key, required this.task}) : super(key: key);

  void _showDeleteConfirmation(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.borderRadiusCozy)),
        title: Text(l10n.deleteConfirmationTitle),
        content: Text(l10n.deleteConfirmationBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error),
            onPressed: () {
              context.read<GamificationBloc>().add(DeleteTaskEvent(task.id));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.taskDeletedToast)));
              Navigator.of(ctx).pop(); // Close dialog
              Navigator.of(context).pop(); // Close bottom sheet
            },
            child: Text(l10n.confirm),
          ),
        ],
      ),
    );
  }

  void _openEditSheet(BuildContext context) {
    final state = context.read<GamificationBloc>().state;
    if (state is GamificationLoaded) {
      Navigator.of(context).pop(); // Close detail sheet
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => AddTaskBottomSheet(
          categories: state.categories,
          taskToEdit: task,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    DateTime dueDate = DateTime.now();
    try {
      dueDate = DateTime.parse(task.dueDate);
    } catch (_) {}

    return Container(
      padding: EdgeInsets.only(
        left: AppConstants.paddingLarge,
        right: AppConstants.paddingLarge,
        top: AppConstants.paddingLarge,
        bottom: bottomPadding + AppConstants.paddingLarge,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(AppConstants.borderRadiusCozy)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.taskDetailsTitle,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppConstants.paddingLarge),

          Text(
            task.title,
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppConstants.paddingSmall),
          
          if (task.description != null && task.description!.isNotEmpty) ...[
            Text(
              task.description!,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: AppConstants.paddingMedium),
          ],

          Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: theme.colorScheme.secondary),
              const SizedBox(width: AppConstants.paddingSmall),
              Text(
                DateFormat.yMMMd().format(dueDate),
                style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Icon(Icons.category, size: 16, color: theme.colorScheme.secondary),
              const SizedBox(width: AppConstants.paddingSmall),
              Text(
                _getCategoryName(l10n, task.categoryIconKey, task.categoryName),
                style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.paddingLarge),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton.icon(
                onPressed: () => _showDeleteConfirmation(context, l10n),
                icon: const Icon(Icons.delete, color: Colors.redAccent),
                label: Text(l10n.deleteTask, style: const TextStyle(color: Colors.redAccent)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.redAccent),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.borderRadiusCozy)),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
              FilledButton.icon(
                onPressed: () => _openEditSheet(context),
                icon: const Icon(Icons.edit),
                label: Text(l10n.editTask),
                style: FilledButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  String _getCategoryName(AppLocalizations l10n, String key, String defaultName) {
    switch (key) {
      case 'medical': return l10n.categoryMedical;
      case 'habit': return l10n.categoryHabit;
      case 'event': return l10n.categoryEvent;
      case 'task': return l10n.categoryTask;
      default: return defaultName;
    }
  }
}
