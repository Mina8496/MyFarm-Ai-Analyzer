import 'package:myfarm/features/shared_notes/domain/entities/group_note_entity.dart';

abstract class NotesGroupState {}

class NotesGroupInitial extends NotesGroupState {}
class NotesGroupBusy extends NotesGroupState {}

class NotesGroupError extends NotesGroupState {
  final String message;
  NotesGroupError(this.message);
}

class NotesGroupReady extends NotesGroupState {
  final String groupId;
  final String groupName;
  final List<GroupNoteEntity> notes;
  NotesGroupReady({required this.groupId, required this.groupName, required this.notes});
}