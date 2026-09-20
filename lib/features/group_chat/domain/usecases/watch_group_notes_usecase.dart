import 'package:myfarm/features/shared_notes/domain/entities/group_note_entity.dart';
import 'package:myfarm/features/shared_notes/domain/repositories/notes_group_repository.dart';

class WatchGroupNotesUseCase {
  final NotesGroupRepo repo;
  WatchGroupNotesUseCase(this.repo);

  Stream<List<GroupNoteEntity>> call(String groupId) => repo.watchNotes(groupId);
}