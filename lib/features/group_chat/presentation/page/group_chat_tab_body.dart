import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfarm/features/shared_notes/presentation/manger/notes_group_cubit.dart';
import 'package:myfarm/features/shared_notes/presentation/manger/notes_group_state.dart';
import 'package:myfarm/features/shared_notes/presentation/page/widgets/group_notes_view.dart';
import 'package:myfarm/features/shared_notes/presentation/page/widgets/join_create_view.dart';

class SharedNotesTabBody extends StatefulWidget {
  const SharedNotesTabBody({super.key});

  @override
  State<SharedNotesTabBody> createState() => _SharedNotesTabBodyState();
}

class _SharedNotesTabBodyState extends State<SharedNotesTabBody> {
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
    return BlocConsumer<NotesGroupCubit, NotesGroupState>(
      listener: (context, state) {
        if (state is NotesGroupError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is NotesGroupReady) {
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
          busy: state is NotesGroupBusy,
        );
      },
    );
  }
}