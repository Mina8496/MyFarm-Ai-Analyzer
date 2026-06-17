import 'package:myfarm/features/tasks/data/model/task_model.dart';


abstract class TaskRepo {
  Future<List<TaskModel>> getAllTasks();
  Future<void> addTask(TaskModel task);
  Future<void> editTask({
    required String taskId,
    required String newTitle,
    required String newDescription,
  });
  Future<void> deleteTask(String taskId);
  Future<void> toggleComplete(String taskId);
}