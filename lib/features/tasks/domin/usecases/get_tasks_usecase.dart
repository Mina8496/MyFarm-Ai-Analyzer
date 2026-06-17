import 'package:myfarm/features/tasks/data/model/task_model.dart';
import 'package:myfarm/features/tasks/domin/repositories/task_repository.dart';
 
class GetTasksUseCase {
  final TaskRepo repo;
  GetTasksUseCase(this.repo);
 
  Future<List<TaskModel>> call() => repo.getAllTasks();
}