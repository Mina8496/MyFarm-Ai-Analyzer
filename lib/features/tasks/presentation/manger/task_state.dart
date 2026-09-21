import 'package:myfarm/features/tasks/domin/entities/task_entity.dart';

abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<TaskEntity> tasks;
  final List<TaskEntity> top5Tasks;

  TaskLoaded({
    required this.tasks,
    required this.top5Tasks,
  });
}

class TaskError extends TaskState {
  final String message;
  TaskError(this.message);
}