 
import 'package:myfarm/features/tasks/domin/repositories/task_repository.dart';

class DeleteTaskUsecase {
  final TaskRepo repo;
  DeleteTaskUsecase(this.repo);
 
  Future<void> call(String taskId) => repo.deleteTask(taskId);
}