import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfarm/core/auth/presentation/cubit/auth_cubit.dart';
import 'package:myfarm/core/function/injection_container.dart';
import 'package:myfarm/features/group_chat/presentation/manager/group_chat_cubit.dart';
import 'package:myfarm/features/group_chat/presentation/page/group_chat_tab_body.dart';

class GroupChatTab extends StatelessWidget {
  const GroupChatTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GroupChatCubit(
        createGroupUseCase: getIt(),
        joinGroupUseCase: getIt(),
        watchGroupNotesUseCase: getIt(),
        addGroupNoteUseCase: getIt(),
        getMyGroupsUseCase: getIt(),
        authCubit: context.read<AuthCubit>(),
      ),
      child: const GroupChatTabBody(),
    );
  }
}