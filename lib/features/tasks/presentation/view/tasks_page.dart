import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfarm/core/function/injection_container.dart';
import 'package:myfarm/features/tasks/domin/entities/user_role.dart';
import 'package:myfarm/features/tasks/domin/usecases/add_task_usecase.dart';
import 'package:myfarm/features/tasks/domin/usecases/delete_task_usecase.dart';
import 'package:myfarm/features/tasks/domin/usecases/edit_task_usecase.dart';
import 'package:myfarm/features/tasks/domin/usecases/get_tasks_usecase.dart';
import 'package:myfarm/features/tasks/domin/usecases/toggle_complete_usecase.dart';
import 'package:myfarm/features/tasks/presentation/manger/task_cubit.dart';
import 'package:myfarm/features/tasks/presentation/view/widgets/tasks_view.dart';

class TasksPage extends StatelessWidget {
  final UserRole role;
  const TasksPage({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TaskCubit(
        currentRole: role,
        getTasksUseCase: getIt<GetTasksUseCase>(),
        addTaskUseCase: getIt<AddTaskUseCase>(),
        deleteTaskUseCase: getIt<DeleteTaskUsecase>(),
        editTaskUseCase: getIt<EditTaskUseCase>(),
        toggleCompleteUseCase: getIt<ToggleCompleteUseCase>(),
      )..loadTasks(),
      child: TasksView(role: role),
    );
  }
}