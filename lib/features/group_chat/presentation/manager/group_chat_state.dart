import 'package:myfarm/features/group_chat/domain/entities/group_note_entity.dart';
import 'package:myfarm/features/group_chat/domain/entities/joined_group_entity.dart';

abstract class GroupChatState {}

class GroupChatInitial extends GroupChatState {
  final List<JoinedGroupEntity> joinedGroups;
  final bool loadingJoinedGroups;

  GroupChatInitial({
    this.joinedGroups = const [],
    this.loadingJoinedGroups = false,
  });
}

class GroupChatBusy extends GroupChatState {}

class GroupChatError extends GroupChatState {
  final String message;
  GroupChatError(this.message);
}

class GroupChatReady extends GroupChatState {
  final String groupId;
  final String groupName;
  final List<GroupNoteEntity> notes;
  GroupChatReady({
    required this.groupId,
    required this.groupName,
    required this.notes,
  });
}