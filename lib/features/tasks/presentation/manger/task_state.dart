
import 'package:myfarm/features/tasks/data/model/task_model.dart';

abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<TaskModel> tasks;
  final List<TaskModel> top5Tasks;

  TaskLoaded({
    required this.tasks,
    required this.top5Tasks,
  });
}

class TaskError extends TaskState {
  final String message;
  TaskError(this.message);
}