
import 'package:myfarm/features/shared_notes/domain/repositories/notes_group_repository.dart';

class AddGroupNoteUseCase {
  final NotesGroupRepo repo;
  AddGroupNoteUseCase(this.repo);

  Future<void> call({
    required String groupId,
    required String content,
    required String authorName,
  }) =>
      repo.addNote(groupId: groupId, content: content, authorName: authorName);
}