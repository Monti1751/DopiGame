import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/task.dart';
import 'package:dopi_game/l10n/app_localizations.dart';
import 'task_detail_sheet.dart';

class TaskCard extends StatelessWidget {
  final TaskEntity task;
  final int index;
  final VoidCallback onComplete;

  const TaskCard({Key? key, required this.task, required this.index, required this.onComplete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    
    // Calculates total XP
    int roundedXp = (task.baseXp * task.priorityMultiplier).round();

    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => TaskDetailSheet(task: task),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingSmall, vertical: AppConstants.paddingMedium),
        child: Row(
          children: [
            ReorderableDragStartListener(
              index: index, 
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(Icons.drag_indicator, color: Colors.grey),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(AppConstants.paddingSmall),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getCategoryIcon(task.categoryIconKey),
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(width: AppConstants.paddingMedium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    _getCategoryName(l10n, task.categoryIconKey, task.categoryName),
                    style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.secondary),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),

                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, size: 16, color: theme.colorScheme.secondary),
                      const SizedBox(width: 4),
                      Text(
                        '+$roundedXp XP',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.check_circle_outline,
                color: theme.colorScheme.primary,
                size: 32,
              ),
              onPressed: onComplete,
            ),
          ],
        ),
      ),
      ),
    );
  }

  IconData _getCategoryIcon(String key) {
    switch (key) {
      case 'medical': return Icons.local_hospital;
      case 'habit': return Icons.favorite;
      case 'event': return Icons.event;
      default: return Icons.task;
    }
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
