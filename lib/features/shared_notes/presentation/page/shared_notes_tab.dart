import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfarm/core/function/injection_container.dart';
import 'package:myfarm/features/shared_notes/domain/usecases/add_group_note_usecase.dart';
import 'package:myfarm/features/shared_notes/domain/usecases/create_group_usecase.dart';
import 'package:myfarm/features/shared_notes/domain/usecases/get_joined_groups_usecase.dart';
import 'package:myfarm/features/shared_notes/domain/usecases/join_group_usecase.dart';
import 'package:myfarm/features/shared_notes/domain/usecases/save_joined_group_usecase.dart';
import 'package:myfarm/features/shared_notes/domain/usecases/watch_group_notes_usecase.dart';
import 'package:myfarm/features/shared_notes/presentation/manger/notes_group_cubit.dart';
import 'package:myfarm/features/shared_notes/presentation/page/shared_notes_tab_body.dart';

class SharedNotesTab extends StatelessWidget {
  const SharedNotesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final user = fb.FirebaseAuth.instance.currentUser;

    return BlocProvider(
      create: (_) => NotesGroupCubit(
        createGroupUseCase: getIt<CreateGroupUseCase>(),
        joinGroupUseCase: getIt<JoinGroupUseCase>(),
        watchGroupNotesUseCase: getIt<WatchGroupNotesUseCase>(),
        addGroupNoteUseCase: getIt<AddGroupNoteUseCase>(),
        getJoinedGroupsUseCase: getIt<GetJoinedGroupsUseCase>(),
        saveJoinedGroupUseCase: getIt<SaveJoinedGroupUseCase>(),
        currentUserName: user?.displayName ?? user?.email ?? 'مستخدم',
      ),
      child: const SharedNotesTabBody(),
    );
  }
}