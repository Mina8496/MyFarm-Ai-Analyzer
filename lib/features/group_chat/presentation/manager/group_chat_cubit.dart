import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfarm/core/auth/presentation/cubit/auth_cubit.dart';
import 'package:myfarm/core/auth/presentation/cubit/auth_state.dart';
import 'package:myfarm/features/group_chat/domain/entities/group_note_entity.dart';
import 'package:myfarm/features/group_chat/domain/entities/joined_group_entity.dart';
import 'package:myfarm/features/group_chat/domain/usecases/add_group_note_usecase.dart';
import 'package:myfarm/features/group_chat/domain/usecases/create_group_usecase.dart';
import 'package:myfarm/features/group_chat/domain/usecases/get_my_groups_usecase.dart';
import 'package:myfarm/features/group_chat/domain/usecases/join_group_usecase.dart';
import 'package:myfarm/features/group_chat/domain/usecases/watch_group_notes_usecase.dart';
import 'package:myfarm/features/group_chat/presentation/manager/group_chat_state.dart';

class GroupChatCubit extends Cubit<GroupChatState> {
  final CreateGroupUseCase createGroupUseCase;
  final JoinGroupUseCase joinGroupUseCase;
  final WatchGroupNotesUseCase watchGroupNotesUseCase;
  final AddGroupNoteUseCase addGroupNoteUseCase;
  final GetMyGroupsUseCase getMyGroupsUseCase;
  final AuthCubit authCubit;

  String _currentUserId;
  String _currentUserName;

  String get currentUserId => _currentUserId;
  String get currentUserName => _currentUserName;

  StreamSubscription<List<GroupNoteEntity>>? _sub;
  StreamSubscription<AuthState>? _authSub;
  String? _groupId;

  GroupChatCubit({
    required this.createGroupUseCase,
    required this.joinGroupUseCase,
    required this.watchGroupNotesUseCase,
    required this.addGroupNoteUseCase,
    required this.getMyGroupsUseCase,
    required this.authCubit,
  }) : _currentUserId = _idFromAuthState(authCubit.state),
       _currentUserName = _nameFromAuthState(authCubit.state),
       super(GroupChatInitial()) {
    _authSub = authCubit.stream.listen(_onAuthChanged);
    refreshJoinedGroups();
  }

  static String _idFromAuthState(AuthState state) =>
      state is AuthAuthenticated ? state.user.id : '';

  static String _nameFromAuthState(AuthState state) =>
      state is AuthAuthenticated ? state.user.displayNameOrFallback : 'مستخدم';

  void _onAuthChanged(AuthState authState) {
    final newId = _idFromAuthState(authState);
    if (newId == _currentUserId) return;

    _currentUserId = newId;
    _currentUserName = _nameFromAuthState(authState);

    _sub?.cancel();
    _groupId = null;
    refreshJoinedGroups();
  }

  Future<void> refreshJoinedGroups() async {
    final current = state is GroupChatInitial
        ? (state as GroupChatInitial).joinedGroups
        : const <JoinedGroupEntity>[];
    emit(GroupChatInitial(joinedGroups: current, loadingJoinedGroups: true));
    try {
      final groups = await getMyGroupsUseCase(_currentUserId);
      emit(GroupChatInitial(joinedGroups: groups));
    } catch (_) {
      emit(GroupChatInitial());
    }
  }

  Future<void> createGroup(String groupName) async {
    emit(GroupChatBusy());
    final name = groupName.trim().isEmpty
        ? 'مجموعة بدون اسم'
        : groupName.trim();
    try {
      final id = await createGroupUseCase.call(
        creatorId: _currentUserId,
        creatorName: _currentUserName,
        groupName: name,
      );
      _startWatching(id, name);
    } catch (e) {
      emit(GroupChatError('تعذر إنشاء المجموعة: $e'));
    }
  }

  Future<void> joinGroup(String groupId) async {
    final trimmedId = groupId.trim();
    if (trimmedId.isEmpty) return;
    emit(GroupChatBusy());
    try {
      final name = await joinGroupUseCase.call(trimmedId, _currentUserId);
      if (name == null) {
        emit(GroupChatError('لا توجد مجموعة بهذا الرقم'));
        return;
      }
      _startWatching(trimmedId, name);
    } catch (e) {
      emit(GroupChatError('حدث خطأ: $e'));
    }
  }

  void leaveGroup() {
    _sub?.cancel();
    _groupId = null;
    refreshJoinedGroups();
  }

  void _startWatching(String groupId, String groupName) {
    _groupId = groupId;
    _sub?.cancel();
    _sub = watchGroupNotesUseCase
        .call(groupId)
        .listen(
          (notes) => emit(
            GroupChatReady(
              groupId: groupId,
              groupName: groupName,
              notes: notes,
            ),
          ),
          onError: (e) => emit(GroupChatError('حدث خطأ أثناء التحميل: $e')),
        );
  }

  Future<void> addNote(String content) async {
    final id = _groupId;
    final text = content.trim();
    if (id == null || text.isEmpty) return;
    try {
      await addGroupNoteUseCase.call(
        groupId: id,
        authorId: _currentUserId,
        content: text,
        authorName: _currentUserName,
      );
    } catch (e) {
      emit(GroupChatError('تعذر إرسال الملاحظة: $e'));
    }
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    _authSub?.cancel();
    return super.close();
  }
}