import 'package:flutter/material.dart';
import 'package:myfarm/core/utils/styles.dart';
import 'package:myfarm/features/tasks/presentation/view/widgets/task_card.dart';
import 'package:myfarm/core/theme/app_theme.dart';

class TaskContent extends StatelessWidget {
  const TaskContent({super.key, required this.task, required this.isCompleted});

  final TaskCard task;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.task.title,
            style: TextStyle(
              color: isCompleted ? colors.textSecondary : colors.textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
              decoration: isCompleted
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
          if (task.task.description.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              task.task.description,
              style: Styles.style12.copyWith(
                color: isCompleted
                    ? colors.textSecondary.withValues(alpha: 0.7)
                    : colors.textSecondary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.person_outline, size: 12, color: colors.textSecondary),
              const SizedBox(width: 4),
              Text(
                task.task.createdByRole,
                style: Styles.style12.copyWith(color: colors.textSecondary),
              ),
              const Spacer(),
              if (!isCompleted)
                Text(
                  'Double Tap للإكمال',
                  style: Styles.style12.copyWith(
                    color: colors.textSecondary.withValues(alpha: 0.7),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
