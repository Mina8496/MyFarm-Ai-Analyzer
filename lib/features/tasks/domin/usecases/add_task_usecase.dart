import 'package:myfarm/features/tasks/domin/entities/task_entity.dart';
import 'package:myfarm/features/tasks/domin/repositories/task_repository.dart';

class AddTaskUseCase {
  final TaskRepo repo;
  AddTaskUseCase(this.repo);

  Future<void> call(TaskEntity task) => repo.addTask(task);
}