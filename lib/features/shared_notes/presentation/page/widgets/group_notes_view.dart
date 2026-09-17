import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfarm/common/constants/color_palette.dart';
import 'package:myfarm/core/utils/styles.dart';
import 'package:myfarm/features/shared_notes/presentation/manger/notes_group_cubit.dart';

class GroupNotesView extends StatelessWidget {
  final String groupId;
  final String groupName;
  final List notes; // List<GroupNoteModel>
  final TextEditingController noteController;

  const GroupNotesView({
    super.key,
    required this.groupId,
    required this.groupName,
    required this.notes,
    required this.noteController,
  });

  void _sendNote(BuildContext context) {
    final text = noteController.text.trim();
    if (text.isEmpty) return;
    context.read<NotesGroupCubit>().addNote(text);
    noteController.clear();
  }

  String _formatTime(DateTime dt) {
    final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final minute = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour >= 12 ? 'م' : 'ص';
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    final currentUserName = context.read<NotesGroupCubit>().currentUserName;

    return Column(
      children: [
        _buildHeader(context),
        Expanded(
          child: notes.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final note = notes[index];
                    final isMine = note.authorName == currentUserName;
                    return _NoteBubble(
                      content: note.content,
                      authorName: note.authorName,
                      time: _formatTime(note.createdAt),
                      isMine: isMine,
                    );
                  },
                ),
        ),
        _buildInputBar(context),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: const BoxDecoration(
        color: Color(0x0DFFFFFF),
        border: Border(bottom: BorderSide(color: Colors.white12, width: 1)),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: ColorPalette.kBlackColor),
            onPressed: () => context.read<NotesGroupCubit>().leaveGroup(),
            tooltip: 'رجوع للمجموعات',
          ),
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.teal.withValues(alpha: 0.9),
            child: Text(
              groupName.isNotEmpty ? groupName[0] : '?',
              style: Styles.style16,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  groupName,
                  style: Styles.style18,
                  overflow: TextOverflow.ellipsis,
                ),
                Text('رقم المجموعة: $groupId', style: Styles.style16),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.copy, size: 18, color: Colors.black),
            tooltip: 'نسخ رقم المجموعة',
            onPressed: () {
              Clipboard.setData(ClipboardData(text: groupId));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم نسخ رقم المجموعة')),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.chat_bubble_outline, size: 48, color: Colors.white24),
          SizedBox(height: 12),
          Text(
            'لا توجد ملاحظات بعد',
            style: TextStyle(color: Colors.white54, fontSize: 14),
          ),
          SizedBox(height: 4),
          Text(
            'ابدأ أول ملاحظة في المجموعة',
            style: TextStyle(color: Colors.white38, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildInputBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
        top: 8,
        bottom: MediaQuery.of(context).viewInsets.bottom + 8,
      ),
      decoration: const BoxDecoration(
        color: Color(0x0DFFFFFF),
        border: Border(top: BorderSide(color: Colors.white12, width: 1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              constraints: BoxConstraints(maxHeight: 120),
              decoration: BoxDecoration(
                color: ColorPalette.kBlackColor.withValues(alpha: 0.09),
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                controller: noteController,
                style: const TextStyle(color: ColorPalette.kBorder),
                minLines: 1,
                maxLines: 4,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _sendNote(context),
                decoration: const InputDecoration(
                  hintText: 'اكتب ملاحظة...',
                  hintStyle: TextStyle(color: ColorPalette.kBlackColor),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Material(
            color: Colors.teal,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () => _sendNote(context),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.send,
                  color: ColorPalette.kWhiteColor,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NoteBubble extends StatelessWidget {
  final String content;
  final String authorName;
  final String time;
  final bool isMine;

  const _NoteBubble({
    required this.content,
    required this.authorName,
    required this.time,
    required this.isMine,
  });

  @override
  Widget build(BuildContext context) {
    final bubbleColor = isMine
        ? Colors.teal.withValues(alpha: 0.85)
        : Colors.white.withValues(alpha: 0.10);

    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 6),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(14),
            topRight: const Radius.circular(14),
            bottomRight: Radius.circular(isMine ? 2 : 14),
            bottomLeft: Radius.circular(isMine ? 14 : 2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isMine)
              Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(
                  authorName,
                  style: const TextStyle(
                    color: Colors.tealAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            Text(
              content,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
            const SizedBox(height: 3),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                time,
                style: const TextStyle(color: Colors.white54, fontSize: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
