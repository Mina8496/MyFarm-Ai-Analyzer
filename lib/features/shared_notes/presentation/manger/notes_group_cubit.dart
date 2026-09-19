import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfarm/features/shared_notes/domain/entities/group_note_entity.dart';
import 'package:myfarm/features/shared_notes/domain/entities/joined_group_entity.dart';
import 'package:myfarm/features/shared_notes/domain/usecases/add_group_note_usecase.dart';
import 'package:myfarm/features/shared_notes/domain/usecases/create_group_usecase.dart';
import 'package:myfarm/features/shared_notes/domain/usecases/get_my_groups_usecase.dart';
import 'package:myfarm/features/shared_notes/domain/usecases/join_group_usecase.dart';
import 'package:myfarm/features/shared_notes/domain/usecases/watch_group_notes_usecase.dart';
import 'package:myfarm/features/shared_notes/presentation/manger/notes_group_state.dart';

class NotesGroupCubit extends Cubit<NotesGroupState> {
  final CreateGroupUseCase createGroupUseCase;
  final JoinGroupUseCase joinGroupUseCase;
  final WatchGroupNotesUseCase watchGroupNotesUseCase;
  final AddGroupNoteUseCase addGroupNoteUseCase;
  final GetMyGroupsUseCase getMyGroupsUseCase;
  final String currentUserId;   // ⬅️ جديد
  final String currentUserName;

  StreamSubscription<List<GroupNoteEntity>>? _sub;
  String? _groupId;

  NotesGroupCubit({
    required this.createGroupUseCase,
    required this.joinGroupUseCase,
    required this.watchGroupNotesUseCase,
    required this.addGroupNoteUseCase,
    required this.getMyGroupsUseCase,
    required this.currentUserId,
    required this.currentUserName,
  }) : super(NotesGroupInitial());

  Future<List<JoinedGroupEntity>> loadJoinedGroups() =>
      getMyGroupsUseCase(currentUserId);

  Future<void> createGroup(String groupName) async {
    emit(NotesGroupBusy());
    final name = groupName.trim().isEmpty ? 'مجموعة بدون اسم' : groupName.trim();
    try {
      final id = await createGroupUseCase.call(
        creatorId: currentUserId,
        creatorName: currentUserName,
        groupName: name,
      );
      _startWatching(id, name);
    } catch (e) {
      emit(NotesGroupError('تعذر إنشاء المجموعة: $e'));
    }
  }

  Future<void> joinGroup(String groupId) async {
    final trimmedId = groupId.trim();
    if (trimmedId.isEmpty) return;
    emit(NotesGroupBusy());
    try {
      final name = await joinGroupUseCase.call(trimmedId, currentUserId);
      if (name == null) {
        emit(NotesGroupError('لا توجد مجموعة بهذا الرقم'));
        return;
      }
      _startWatching(trimmedId, name);
    } catch (e) {
      emit(NotesGroupError('حدث خطأ: $e'));
    }
  }

  void leaveGroup() {
    _sub?.cancel();
    _groupId = null;
    emit(NotesGroupInitial());
  }

  void _startWatching(String groupId, String groupName) {
    _groupId = groupId;
    _sub?.cancel();
    _sub = watchGroupNotesUseCase.call(groupId).listen(
      (notes) => emit(NotesGroupReady(groupId: groupId, groupName: groupName, notes: notes)),
      onError: (e) => emit(NotesGroupError('حدث خطأ أثناء التحميل: $e')),
    );
  }

  Future<void> addNote(String content) async {
    final id = _groupId;
    final text = content.trim();
    if (id == null || text.isEmpty) return;
    try {
      await addGroupNoteUseCase.call(groupId: id, content: text, authorName: currentUserName);
    } catch (e) {
      emit(NotesGroupError('تعذر إرسال الملاحظة: $e'));
    }
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}