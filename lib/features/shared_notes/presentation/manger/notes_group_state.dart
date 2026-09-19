import 'package:myfarm/features/shared_notes/domain/entities/group_note_entity.dart';
import 'package:myfarm/features/shared_notes/domain/entities/joined_group_entity.dart';

abstract class NotesGroupState {}

/// بقت بتحمل قايمة "مجموعاتك" نفسها، مش الـ widget هو اللي بيجيبها.
class NotesGroupInitial extends NotesGroupState {
  final List<JoinedGroupEntity> joinedGroups;
  final bool loadingJoinedGroups;

  NotesGroupInitial({
    this.joinedGroups = const [],
    this.loadingJoinedGroups = false,
  });
}

class NotesGroupBusy extends NotesGroupState {}

class NotesGroupError extends NotesGroupState {
  final String message;
  NotesGroupError(this.message);
}

class NotesGroupReady extends NotesGroupState {
  final String groupId;
  final String groupName;
  final List<GroupNoteEntity> notes;
  NotesGroupReady({
    required this.groupId,
    required this.groupName,
    required this.notes,
  });
}