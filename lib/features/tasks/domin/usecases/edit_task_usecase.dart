 
import 'package:myfarm/features/tasks/domin/repositories/task_repository.dart';

class EditTaskUseCase {
  final TaskRepo repo;
  EditTaskUseCase(this.repo);
 
  Future<void> call({
    required String taskId,
    required String newTitle,
    required String newDescription,
  }) =>
      repo.editTask(
        taskId: taskId,
        newTitle: newTitle,
        newDescription: newDescription,
      );
}