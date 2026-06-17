import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfarm/common/constants/color_palette.dart';
import 'package:myfarm/core/utils/styles.dart';
import 'package:myfarm/features/tasks/data/model/task_model.dart';
import 'package:myfarm/features/tasks/domin/entities/user_role.dart';
import 'package:myfarm/features/tasks/presentation/manger/task_cubit.dart';
import 'package:myfarm/features/tasks/presentation/view/widgets/delete_task_dialog.dart';
import 'package:myfarm/features/tasks/presentation/view/widgets/task_card.dart';

class TaskList extends StatelessWidget {
  final List<TaskModel> tasks;
  final UserRole role;
  final String emptyMessage;
  final Function(TaskModel task)? onEdit;

  const TaskList({
    super.key,
    required this.tasks,
    required this.role,
    required this.emptyMessage,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('🌱', style: TextStyle(fontSize: 48)),
            const SizedBox(height: 16),
            Text(
              emptyMessage,
              textAlign: TextAlign.center,
              style: Styles.style16.copyWith(color: ColorPalette.kGreen),
            ),
          ],
        ),
      );
    }

    final cubit = context.read<TaskCubit>();

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return TaskCard(
          task: task,
          currentRole: role,
          onDoubleTap: () => cubit.toggleComplete(task.id),
          onEdit: role.canEdit ? () => onEdit?.call(task) : null,
          onDelete: role.canDelete
              ? () => showDeleteTaskDialog(context, cubit, task)
              : null,
        );
      },
    );
  }
}
