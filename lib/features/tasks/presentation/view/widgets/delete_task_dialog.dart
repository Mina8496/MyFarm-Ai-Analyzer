import 'package:flutter/material.dart';
import 'package:myfarm/common/constants/color_palette.dart';
import 'package:myfarm/core/utils/styles.dart';
import 'package:myfarm/features/tasks/data/model/task_model.dart';
import 'package:myfarm/features/tasks/presentation/manger/task_cubit.dart';

Future<void> showDeleteTaskDialog(
  BuildContext context,
  TaskCubit cubit,
  TaskModel task,
) async {
  return showDialog<void>(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: ColorPalette.kSuccess,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text('حذف المهمة', style: Styles.style16),
      content: Text('هل تريد حذف "${task.title}"؟', style: Styles.style16),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('إلغاء', style: Styles.style14),
        ),
        TextButton(
          onPressed: () {
            cubit.deleteTask(task.id);
            Navigator.pop(context);
          },
          child: Text(
            'حذف',
            style: Styles.style14.copyWith(color: ColorPalette.kLightRed),
          ),
        ),
      ],
    ),
  );
}
