import 'package:myfarm/features/tasks/domin/entities/task_entity.dart';
import 'package:myfarm/features/tasks/domin/repositories/task_repository.dart';

class GetTasksUseCase {
  final TaskRepo repo;
  GetTasksUseCase(this.repo);

  Future<List<TaskEntity>> call() => repo.getAllTasks();
}