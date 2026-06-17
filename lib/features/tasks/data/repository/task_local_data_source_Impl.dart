import 'package:hive/hive.dart';
import 'package:myfarm/features/tasks/data/datasource/task_local_datasource.dart';
import 'package:myfarm/features/tasks/data/model/task_model.dart';

class TaskLocalDataSourceImpl
    implements TaskLocalDataSource {
  static const boxName = 'tasks_box';

  Future<Box<TaskModel>> get _box async =>
      await Hive.openBox<TaskModel>(boxName);

  @override
  Future<List<TaskModel>> getTasks() async {
    final box = await _box;
    return box.values.toList();
  }

  @override
  Future<void> addTask(TaskModel task) async {
    final box = await _box;
    await box.put(task.id, task);
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    final box = await _box;
    await box.put(task.id, task);
  }

  @override
  Future<void> deleteTask(String id) async {
    final box = await _box;
    await box.delete(id);
  }
}