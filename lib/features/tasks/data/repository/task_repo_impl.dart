import 'package:myfarm/features/tasks/data/datasource/task_local_datasource.dart';
import 'package:myfarm/features/tasks/data/model/task_model.dart';
import 'package:myfarm/features/tasks/domin/repositories/task_repository.dart';

class TaskRepoImpl implements TaskRepo {
  final TaskLocalDataSource _dataSource;

  TaskRepoImpl(this._dataSource);

  @override
  Future<List<TaskModel>> getAllTasks() => _dataSource.getTasks();

  @override
  Future<void> addTask(TaskModel task) => _dataSource.addTask(task);

  @override
  Future<void> editTask({
    required String taskId,
    required String newTitle,
    required String newDescription,
  }) async {
    final tasks = await _dataSource.getTasks();
    final task = tasks.firstWhere((t) => t.id == taskId);
    await _dataSource.updateTask(
      task.copyWith(title: newTitle, description: newDescription),
    );
  }

  @override
  Future<void> deleteTask(String taskId) => _dataSource.deleteTask(taskId);

  @override
  Future<void> toggleComplete(String taskId) async {
    final tasks = await _dataSource.getTasks();
    final task = tasks.firstWhere((t) => t.id == taskId);
    await _dataSource.updateTask(
      task.copyWith(isCompleted: !task.isCompleted),
    );
  }
}