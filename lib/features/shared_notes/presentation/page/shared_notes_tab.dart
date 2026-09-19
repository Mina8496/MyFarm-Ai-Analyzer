import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfarm/core/auth/presentation/cubit/auth_cubit.dart';
import 'package:myfarm/core/auth/presentation/cubit/auth_state.dart';
import 'package:myfarm/core/function/injection_container.dart';
import 'package:myfarm/features/shared_notes/presentation/manger/notes_group_cubit.dart';
import 'package:myfarm/features/shared_notes/presentation/page/shared_notes_tab_body.dart';

class SharedNotesTab extends StatelessWidget {
  const SharedNotesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;
    final user = authState is AuthAuthenticated ? authState.user : null;

    return BlocProvider(
      create: (_) => NotesGroupCubit(
        createGroupUseCase: getIt(),
        joinGroupUseCase: getIt(),
        watchGroupNotesUseCase: getIt(),
        addGroupNoteUseCase: getIt(),
        getMyGroupsUseCase: getIt(),
        currentUserId: user?.id ?? '',
        currentUserName: user?.displayNameOrFallback ?? 'مستخدم',
      ),
      child: const SharedNotesTabBody(),
    );
  }
}