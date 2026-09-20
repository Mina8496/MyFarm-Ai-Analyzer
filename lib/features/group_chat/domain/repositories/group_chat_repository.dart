import 'package:myfarm/features/group_chat/domain/entities/group_note_entity.dart';
import 'package:myfarm/features/group_chat/domain/entities/joined_group_entity.dart';

abstract class GroupChatRepository {
  Future<String> createGroup({
    required String creatorId,
    required String creatorName,
    required String groupName,
  });

  Future<String?> getGroupName(String groupId);

  Future<void> addMember({required String groupId, required String userId});

  /// المجموعات اللي الـ userId ده عضو فيها فعليًا حسب Firestore.
  Future<List<JoinedGroupEntity>> getMyGroups(String userId);

  Stream<List<GroupNoteEntity>> watchNotes(String groupId);

  Future<void> addNote({
    required String groupId,
    required String authorId,
    required String content,
    required String authorName,
  });
}