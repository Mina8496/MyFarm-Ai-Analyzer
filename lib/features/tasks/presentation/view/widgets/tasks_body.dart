import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfarm/common/constants/color_palette.dart';
import 'package:myfarm/core/utils/styles.dart';
import 'package:myfarm/features/tasks/data/model/task_model.dart';
import 'package:myfarm/features/tasks/domin/entities/user_role.dart';
import 'package:myfarm/features/tasks/presentation/manger/task_cubit.dart';
import 'package:myfarm/features/tasks/presentation/manger/task_state.dart';
import 'package:myfarm/features/tasks/presentation/view/widgets/task_list.dart';

class TasksBody extends StatelessWidget {
  final TabController tabController;
  final UserRole role;
  final void Function(TaskModel task) onEditTask;

  const TasksBody({
    super.key,
    required this.tabController,
    required this.role,
    required this.onEditTask,
  });

  static const _emptyMessage = 'لا توجد مهام بعد\nأضف مهمتك الأولى!';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) => switch (state) {
        TaskLoading() => const _LoadingIndicator(),
        TaskError()   => _ErrorMessage(message: state.message),
        TaskLoaded()  => _TabContent(
            tabController: tabController,
            state: state,
            role: role,
            onEditTask: onEditTask,
          ),
        _             => const SizedBox.shrink(),
      },
    );
  }
}

// Private helpers

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) => const Center(
        child: CircularProgressIndicator(color: ColorPalette.kPrimaryBlue),
      );
}

class _ErrorMessage extends StatelessWidget {
  final String message;
  const _ErrorMessage({required this.message});

  @override
  Widget build(BuildContext context) => Center(
        child: Text(
          message,
          style: Styles.style14.copyWith(color: Colors.redAccent),
        ),
      );
}

class _TabContent extends StatelessWidget {
  final TabController tabController;
  final TaskLoaded state;
  final UserRole role;
  final void Function(TaskModel) onEditTask;

  const _TabContent({
    required this.tabController,
    required this.state,
    required this.role,
    required this.onEditTask,
  });

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: [
        TaskList(
          tasks: state.top5Tasks,
          role: role,
          emptyMessage: TasksBody._emptyMessage,
          onEdit: onEditTask,
        ),
        TaskList(
          tasks: state.tasks,
          role: role,
          emptyMessage: TasksBody._emptyMessage,
          onEdit: onEditTask,
        ),
      ],
    );
  }
}