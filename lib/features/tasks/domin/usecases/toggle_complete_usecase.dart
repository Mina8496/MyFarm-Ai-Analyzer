import 'package:myfarm/features/tasks/domin/repositories/task_repository.dart';

class ToggleCompleteUseCase {
  final TaskRepo repo;
  ToggleCompleteUseCase(this.repo);
 
  Future<void> call(String taskId) => repo.toggleComplete(taskId);
}