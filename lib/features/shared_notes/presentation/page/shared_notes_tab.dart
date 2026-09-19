import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfarm/core/function/injection_container.dart';
import 'package:myfarm/features/shared_notes/presentation/manger/notes_group_cubit.dart';
import 'package:myfarm/features/shared_notes/presentation/page/shared_notes_tab_body.dart';

class SharedNotesTab extends StatelessWidget {
  const SharedNotesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final user = fb.FirebaseAuth.instance.currentUser;

    return BlocProvider(
      create: (_) => NotesGroupCubit(
        createGroupUseCase: getIt(),
        joinGroupUseCase: getIt(),
        watchGroupNotesUseCase: getIt(),
        addGroupNoteUseCase: getIt(),
        getMyGroupsUseCase: getIt(),
        currentUserId: fb.FirebaseAuth.instance.currentUser?.uid ?? '',
        currentUserName: user?.displayName ?? user?.email ?? 'مستخدم',
      ),
      child: const SharedNotesTabBody(),
    );
  }
}
