import 'package:myfarm/features/tasks/domin/entities/task_entity.dart';

abstract class TaskRepo {
  Future<List<TaskEntity>> getAllTasks();
  Future<void> addTask(TaskEntity task);
  Future<void> editTask({
    required String taskId,
    required String newTitle,
    required String newDescription,
  });
  Future<void> deleteTask(String taskId);
  Future<void> toggleComplete(String taskId);
}