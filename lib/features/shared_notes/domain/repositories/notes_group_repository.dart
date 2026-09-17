import 'package:myfarm/features/shared_notes/domain/entities/group_note_entity.dart';

abstract class NotesGroupRepo {
  Future<String> createGroup({
    required String creatorName,
    required String groupName,
  });

  Future<String?> getGroupName(String groupId);

  Stream<List<GroupNoteEntity>> watchNotes(String groupId);

  Future<void> addNote({
    required String groupId,
    required String content,
    required String authorName,
  });
}