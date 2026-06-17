import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myfarm/common/constants/color_palette.dart';
import 'package:myfarm/features/tasks/data/model/task_model.dart';
import 'package:myfarm/features/tasks/domin/entities/user_role.dart';
import 'package:myfarm/features/tasks/presentation/view/widgets/task_actions_menu.dart';
import 'package:myfarm/features/tasks/presentation/view/widgets/task_completion_indicator.dart';
import 'package:myfarm/features/tasks/presentation/view/widgets/task_content.dart';

class TaskCard extends StatefulWidget {
  final TaskModel task;
  final UserRole currentRole;
  final VoidCallback onDoubleTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const TaskCard({
    super.key,
    required this.task,
    required this.currentRole,
    required this.onDoubleTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      lowerBound: 0.95,
      upperBound: 1.0,
      value: 1.0,
    );
    _scaleAnim = _controller;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleDoubleTap() {
    HapticFeedback.mediumImpact();
    _controller.reverse().then((_) => _controller.forward());
    widget.onDoubleTap();
  }

  @override
  Widget build(BuildContext context) {
    final isCompleted = widget.task.isCompleted;

    return ScaleTransition(
      scale: _scaleAnim,
      child: GestureDetector(
        onDoubleTap: _handleDoubleTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.only(bottom: 12),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isCompleted
                ? ColorPalette.kPrimaryColor.withOpacity(0.2)
                : ColorPalette.kLightGreen,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isCompleted
                  ? ColorPalette.kSuccess.withOpacity(0.5)
                  : ColorPalette.kBorder,
              width: 1.5,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Completion indicator
              TaskCompletionIndicator(isCompleted: isCompleted),
              const SizedBox(width: 14),

              // Content
              TaskContent(task: widget, isCompleted: isCompleted),

              // Action buttons
              if (widget.currentRole.canEdit || widget.currentRole.canDelete)
                TaskActionsMenu(
                  canEdit: widget.currentRole.canEdit,
                  canDelete: widget.currentRole.canDelete,
                  onEdit: widget.onEdit,
                  onDelete: widget.onDelete,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
