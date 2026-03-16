import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dopi_game/l10n/app_localizations.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/task_category.dart';
import '../bloc/gamification_bloc.dart';
import '../../domain/entities/task.dart'; // NEW: for TaskEntity
import 'package:intl/intl.dart';

class AddTaskBottomSheet extends StatefulWidget {
  final List<TaskCategory> categories;
  final TaskEntity? taskToEdit; // NEW: support for editing tasks

  const AddTaskBottomSheet({Key? key, required this.categories, this.taskToEdit}) : super(key: key);

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  
  TaskCategory? _selectedCategory;
  DateTime _selectedDate = DateTime.now();
  bool _isHighPriority = false;

  @override
  void initState() {
    super.initState();
    if (widget.taskToEdit != null) {
      final t = widget.taskToEdit!;
      _titleController.text = t.title;
      _descController.text = t.description ?? '';
      _selectedDate = DateTime.parse(t.dueDate);
      _isHighPriority = t.priorityMultiplier > 1.0;
      
      try {
        _selectedCategory = widget.categories.firstWhere((cat) => cat.id == t.categoryId);
      } catch (e) {
        if (widget.categories.isNotEmpty) _selectedCategory = widget.categories.first;
      }
    } else {
      if (widget.categories.isNotEmpty) {
        _selectedCategory = widget.categories.first;
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _selectedCategory != null) {
      if (widget.taskToEdit != null) {
        // Edit mode
        context.read<GamificationBloc>().add(
          UpdateTaskEvent(
            TaskEntity(
               id: widget.taskToEdit!.id,
               categoryId: _selectedCategory!.id,
               title: _titleController.text.trim(),
               dueDate: _selectedDate.toIso8601String(),
               description: _descController.text.trim().isEmpty ? null : _descController.text.trim(),
               priorityMultiplier: _isHighPriority ? 1.5 : 1.0,
               isCompleted: widget.taskToEdit!.isCompleted,
               categoryName: _selectedCategory!.name,
               baseXp: _selectedCategory!.baseXp,
               categoryIconKey: _selectedCategory!.iconKey,
            ),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.taskUpdatedToast)));
      } else {
        // Add mode
        context.read<GamificationBloc>().add(
          AddTaskEvent(
            title: _titleController.text.trim(),
            categoryId: _selectedCategory!.id,
            dueDate: _selectedDate.toIso8601String(),
            description: _descController.text.trim().isEmpty ? null : _descController.text.trim(),
            priorityMultiplier: _isHighPriority ? 1.5 : 1.0,
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.taskCreatedToast)));
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      padding: EdgeInsets.only(
        left: AppConstants.paddingMedium,
        right: AppConstants.paddingMedium,
        top: AppConstants.paddingLarge,
        bottom: bottomPadding + AppConstants.paddingLarge,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(AppConstants.borderRadiusCozy)),
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.taskToEdit != null ? l10n.editTaskTitle : l10n.addTaskTitle,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.paddingLarge),

              // Title
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: l10n.taskNameLabel,
                  hintText: l10n.taskNameHint,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (value) => (value == null || value.trim().isEmpty) ? l10n.errorRequiredField : null,
              ),
              const SizedBox(height: AppConstants.paddingMedium),

              // Description
              TextFormField(
                controller: _descController,
                decoration: InputDecoration(
                  labelText: l10n.taskDescriptionLabel,
                  hintText: l10n.taskDescriptionHint,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: AppConstants.paddingMedium),

              // Category
              if (widget.categories.isNotEmpty) ...[
                DropdownButtonFormField<TaskCategory>(
                  value: _selectedCategory,
                  decoration: InputDecoration(
                    labelText: l10n.categoryLabel,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  items: widget.categories.map((cat) {
                    return DropdownMenuItem(
                      value: cat,
                      child: Text(_getCategoryName(l10n, cat.iconKey, cat.name)),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() { _selectedCategory = val; });
                  },
                ),
                const SizedBox(height: AppConstants.paddingMedium),
              ],

              // Due Date & Priority Row
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => _selectDate(context),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: l10n.dueDateLabel,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text(DateFormat.yMMMd().format(_selectedDate)),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppConstants.paddingMedium),
                  Expanded(
                    child: DropdownButtonFormField<bool>(
                      value: _isHighPriority,
                      decoration: InputDecoration(
                        labelText: l10n.priorityLabel,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      items: [
                        DropdownMenuItem(value: false, child: Text(l10n.priorityNormal, overflow: TextOverflow.ellipsis)),
                        DropdownMenuItem(value: true, child: Text(l10n.priorityHigh, overflow: TextOverflow.ellipsis)),
                      ],
                      onChanged: (val) {
                        setState(() { _isHighPriority = val ?? false; });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.paddingLarge),

              // Submit Button
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  widget.taskToEdit != null ? l10n.updateTaskButton : l10n.saveTaskButton,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
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
