import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfarm/features/group_chat/presentation/manager/group_chat_cubit.dart';
import 'package:myfarm/features/group_chat/presentation/manager/group_chat_state.dart';
import 'package:myfarm/features/group_chat/presentation/page/group_notes_view.dart';
import 'package:myfarm/features/group_chat/presentation/page/join_create_view.dart';

class GroupChatTabBody extends StatefulWidget {
  const GroupChatTabBody({super.key});

  @override
  State<GroupChatTabBody> createState() => _GroupChatTabBodyState();
}

class _GroupChatTabBodyState extends State<GroupChatTabBody> {
  final _joinController = TextEditingController();
  final _nameController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _joinController.dispose();
    _nameController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupChatCubit, GroupChatState>(
      listener: (context, state) {
        if (state is GroupChatError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is GroupChatReady) {
          return GroupNotesView(
            groupId: state.groupId,
            groupName: state.groupName,
            notes: state.notes,
            noteController: _noteController,
          );
        }
        return JoinCreateView(
          joinController: _joinController,
          nameController: _nameController,
          busy: state is GroupChatBusy,
        );
      },
    );
  }
}