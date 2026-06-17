import 'package:flutter/material.dart';
import 'package:myfarm/common/constants/color_palette.dart';
import 'package:myfarm/core/utils/styles.dart';
import 'package:myfarm/features/tasks/presentation/view/widgets/task_card.dart';

class TaskContent extends StatelessWidget {
  const TaskContent({super.key, required this.task, required this.isCompleted});

  final TaskCard task;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.task.title,
            style: TextStyle(
              color: isCompleted
                  ? ColorPalette.kGreen
                  : ColorPalette.kWhiteColor,
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
                    ? ColorPalette.kcardGreen
                    : ColorPalette.kSGreen,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.person_outline, size: 12, color: ColorPalette.kGreen),
              const SizedBox(width: 4),
              Text(
                task.task.createdByRole,
                style: Styles.style12.copyWith(color: ColorPalette.kGreen),
              ),
              const Spacer(),
              if (!isCompleted)
                Text(
                  'Double Tap للإكمال',
                  style: Styles.style12.copyWith(
                    color: ColorPalette.kcardGreen,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
