import 'package:myfarm/features/tasks/data/datasource/task_local_datasource.dart';
import 'package:myfarm/features/tasks/data/model/task_model.dart';
import 'package:myfarm/features/tasks/domin/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepo {
  final TaskLocalDataSource dataSource;
  TaskRepositoryImpl(this.dataSource);

  @override
  Future<List<TaskModel>> getAllTasks() => dataSource.getTasks();

  @override
  Future<void> addTask(TaskModel task) => dataSource.addTask(task);

  @override
  Future<void> editTask({
    required String taskId,
    required String newTitle,
    required String newDescription,
  }) async {
    final tasks = await dataSource.getTasks();
    final task = tasks.firstWhere((t) => t.id == taskId);
    await dataSource.updateTask(
      task.copyWith(title: newTitle, description: newDescription),
    );
  }

  @override
  Future<void> deleteTask(String taskId) => dataSource.deleteTask(taskId);

  @override
  Future<void> toggleComplete(String taskId) async {
    final tasks = await dataSource.getTasks();
    final task = tasks.firstWhere((t) => t.id == taskId);
    await dataSource.updateTask(task.copyWith(isCompleted: !task.isCompleted));
  }
}
