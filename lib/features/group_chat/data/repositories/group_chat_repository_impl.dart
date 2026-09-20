import 'package:myfarm/features/group_chat/data/datasource/group_chat_remote_datasource.dart';
import 'package:myfarm/features/group_chat/data/model/group_note_model.dart';
import 'package:myfarm/features/group_chat/domain/entities/group_note_entity.dart';
import 'package:myfarm/features/group_chat/domain/entities/joined_group_entity.dart';
import 'package:myfarm/features/group_chat/domain/repositories/group_chat_repository.dart';

class GroupChatRepositoryImpl implements GroupChatRepository {
  final GroupChatRemoteDataSource dataSource;
  GroupChatRepositoryImpl(this.dataSource);

  @override
  Future<String> createGroup({
    required String creatorId,
    required String creatorName,
    required String groupName,
  }) =>
      dataSource.createGroup(
        creatorId: creatorId,
        creatorName: creatorName,
        groupName: groupName,
      );

  @override
  Future<String?> getGroupName(String groupId) => dataSource.getGroupName(groupId);

  @override
  Future<void> addMember({required String groupId, required String userId}) =>
      dataSource.addMember(groupId: groupId, userId: userId);

  @override
  Future<List<JoinedGroupEntity>> getMyGroups(String userId) =>
      dataSource.getMyGroups(userId);

  @override
  Stream<List<GroupNoteEntity>> watchNotes(String groupId) =>
      dataSource.watchNotes(groupId).map((models) => List<GroupNoteEntity>.from(models));

  @override
  Future<void> addNote({
    required String groupId,
    required String authorId,
    required String content,
    required String authorName,
  }) {
    final note = GroupNoteModel(
      id: '',
      groupId: groupId,
      content: content,
      authorId: authorId,
      authorName: authorName,
      createdAt: DateTime.now(),
    );
    return dataSource.addNote(note);
  }
}