import 'package:myfarm/features/group_chat/domain/entities/group_note_entity.dart';
import 'package:myfarm/features/group_chat/domain/repositories/group_chat_repository.dart';

class WatchGroupNotesUseCase {
  final GroupChatRepository repo;
  WatchGroupNotesUseCase(this.repo);

  Stream<List<GroupNoteEntity>> call(String groupId) => repo.watchNotes(groupId);
}