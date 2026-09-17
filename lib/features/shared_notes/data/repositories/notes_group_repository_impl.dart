import 'package:myfarm/features/shared_notes/data/datasource/notes_group_remote_datasource.dart';
import 'package:myfarm/features/shared_notes/data/model/group_note_model.dart';
import 'package:myfarm/features/shared_notes/domain/entities/group_note_entity.dart';
import 'package:myfarm/features/shared_notes/domain/repositories/notes_group_repository.dart';

class NotesGroupRepositoryImpl implements NotesGroupRepo {
  final NotesGroupRemoteDataSource dataSource;
  NotesGroupRepositoryImpl(this.dataSource);

  @override
  Future<String> createGroup({required String creatorName, required String groupName}) =>
      dataSource.createGroup(creatorName: creatorName, groupName: groupName);

  @override
  Future<String?> getGroupName(String groupId) => dataSource.getGroupName(groupId);

  @override
  Stream<List<GroupNoteEntity>> watchNotes(String groupId) =>
      dataSource.watchNotes(groupId).map((models) => List<GroupNoteEntity>.from(models));

  @override
  Future<void> addNote({
    required String groupId,
    required String content,
    required String authorName,
  }) {
    final note = GroupNoteModel(
      id: '', groupId: groupId, content: content,
      authorName: authorName, createdAt: DateTime.now(),
    );
    return dataSource.addNote(note);
  }
}