import 'package:myfarm/features/tasks/data/model/task_model.dart';
import 'package:myfarm/features/tasks/domin/repositories/task_repository.dart';
 
class AddTaskUseCase {
  final TaskRepo repo;
  AddTaskUseCase(this.repo);
 
  Future<void> call(TaskModel task) => repo.addTask(task);
}