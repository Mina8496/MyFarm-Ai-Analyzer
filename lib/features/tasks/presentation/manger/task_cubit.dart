import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfarm/features/tasks/data/model/task_model.dart';
import 'package:myfarm/features/tasks/domin/entities/user_role.dart';
import 'package:myfarm/features/tasks/domin/usecases/add_task_usecase.dart';
import 'package:myfarm/features/tasks/domin/usecases/delete_task_usecase.dart';
import 'package:myfarm/features/tasks/domin/usecases/edit_task_usecase.dart';
import 'package:myfarm/features/tasks/domin/usecases/get_tasks_usecase.dart';
import 'package:myfarm/features/tasks/domin/usecases/toggle_complete_usecase.dart';
import 'package:myfarm/features/tasks/presentation/manger/task_state.dart';
import 'package:uuid/uuid.dart';

class TaskCubit extends Cubit<TaskState> {
  final GetTasksUseCase getTasksUseCase;
  final AddTaskUseCase addTaskUseCase;
  final DeleteTaskUsecase deleteTaskUseCase;
  final EditTaskUseCase editTaskUseCase;
  final ToggleCompleteUseCase toggleCompleteUseCase;
  final UserRole currentRole;

  TaskCubit({
    required this.getTasksUseCase,
    required this.addTaskUseCase,
    required this.deleteTaskUseCase,
    required this.editTaskUseCase,
    required this.toggleCompleteUseCase,
    required this.currentRole,
  }) : super(TaskInitial());

  Future<void> loadTasks() async {
    emit(TaskLoading());
    try {
      final allTasks = await getTasksUseCase.call();
      _emitLoaded(allTasks);
    } catch (e) {
      emit(TaskError('فشل تحميل المهام: $e'));
    }
  }

  void _emitLoaded(List<TaskModel> allTasks) {
    final sorted = [...allTasks]
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    final incomplete = sorted.where((t) => !t.isCompleted).toList();
    final completed = sorted.where((t) => t.isCompleted).toList();
    final top5 = [...incomplete, ...completed].take(5).toList();

    emit(TaskLoaded(tasks: sorted, top5Tasks: top5));
  }

  Future<void> addTask({
    required String title,
    required String description,
  }) async {
    if (!currentRole.canCreate) return;

    final task = TaskModel(
      isCompleted: false,
      id: const Uuid().v4(),
      title: title,
      description: description,
      createdAt: DateTime.now(),
      createdByRole: currentRole.displayName,
    );

    await addTaskUseCase.call(task);
    final allTasks = await getTasksUseCase.call();
    _emitLoaded(allTasks);
  }

  Future<void> editTask({
    required String taskId,
    required String newTitle,
    required String newDescription,
  }) async {
    if (!currentRole.canEdit) return;

    await editTaskUseCase.call(
      taskId: taskId,
      newTitle: newTitle,
      newDescription: newDescription,
    );
    final allTasks = await getTasksUseCase.call();
    _emitLoaded(allTasks);
  }

  Future<void> deleteTask(String taskId) async {
    if (!currentRole.canDelete) return;

    await deleteTaskUseCase.call(taskId);
    final allTasks = await getTasksUseCase.call();
    _emitLoaded(allTasks);
  }

  Future<void> toggleComplete(String taskId) async {
    await toggleCompleteUseCase.call(taskId);
    final allTasks = await getTasksUseCase.call();
    _emitLoaded(allTasks);
  }
}
