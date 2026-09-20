import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfarm/common/constants/color_palette.dart';
import 'package:myfarm/core/utils/styles.dart';
import 'package:myfarm/features/group_chat/domain/entities/group_note_entity.dart';
import 'package:myfarm/features/group_chat/presentation/manager/group_chat_cubit.dart';
import 'package:myfarm/features/group_chat/presentation/page/widgets/note_bubble.dart';
import 'package:myfarm/features/group_chat/presentation/utils/avatar_color.dart';
import 'package:myfarm/features/group_chat/presentation/utils/note_time_formatter.dart';

class GroupNotesView extends StatelessWidget {
  final String groupId;
  final String groupName;
  final List<GroupNoteEntity> notes;
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
    context.read<GroupChatCubit>().addNote(text);
    noteController.clear();
  }

  /// ملاحظات بعد الفيكس هيبقى عندها authorId، فبنعتمد عليه (أدق، ومش
  /// بيتلخبط لو فيه اسمين متطابقين). ملاحظات قديمة قبل الفيكس هترجع
  /// authorId فاضي من Firestore، فبنرجع للمقارنة بالاسم عشانها بس.
  bool _isMine(GroupNoteEntity note, GroupChatCubit cubit) {
    if (note.authorId.isNotEmpty) {
      return note.authorId == cubit.currentUserId;
    }
    return note.authorName == cubit.currentUserName;
  }

  bool _sameAuthor(GroupNoteEntity a, GroupNoteEntity b) {
    if (a.authorId.isNotEmpty && b.authorId.isNotEmpty) {
      return a.authorId == b.authorId;
    }
    return a.authorName == b.authorName;
  }

  /// مفتاح ثابت للكاتب: الـ id لو موجود، وإلا الاسم (ملاحظات قديمة).
  String _authorKey(GroupNoteEntity note) =>
      note.authorId.isNotEmpty ? note.authorId : note.authorName;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GroupChatCubit>();

    return Column(
      children: [
        _buildHeader(context),
        Expanded(
          child: notes.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final note = notes[index];
                    final isMine = _isMine(note, cubit);

                    final olderNote = index + 1 < notes.length
                        ? notes[index + 1]
                        : null;
                    final newerNote = index - 1 >= 0 ? notes[index - 1] : null;

                    final isFirstInGroup =
                        olderNote == null || !_sameAuthor(olderNote, note);
                    final isLastInGroup =
                        newerNote == null || !_sameAuthor(newerNote, note);

                    return NoteBubble(
                      content: note.content,
                      authorName: note.authorName,
                      time: NoteTimeFormatter.format(note.createdAt),
                      isMine: isMine,
                      showName: isFirstInGroup && !isMine,
                      showAvatar: isLastInGroup && !isMine,
                      avatarColor: AvatarColor.forName(_authorKey(note)),
                      topSpacing: isFirstInGroup ? 10 : 2,
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
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
      decoration: const BoxDecoration(
        color: ColorPalette.kkPrimaryGreen,
        border: Border(
          bottom: BorderSide(color: ColorPalette.kBorder, width: 1),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: ColorPalette.kWhiteColor),
            onPressed: () => context.read<GroupChatCubit>().leaveGroup(),
            tooltip: 'رجوع للمجموعات',
          ),
          CircleAvatar(
            radius: 15,
            backgroundColor: ColorPalette.kSecondaryGreen,
            child: Text(
              groupName.isNotEmpty ? groupName[0] : '?',
              style: Styles.style12.copyWith(color: ColorPalette.kWhiteColor),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  groupName,
                  style: Styles.style18.copyWith(
                    color: ColorPalette.kWhiteColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'رقم المجموعة: $groupId',
                  style: Styles.style14.copyWith(
                    color: ColorPalette.kWhiteColor.withValues(alpha: 0.75),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.copy,
              size: 15,
              color: ColorPalette.kWhiteColor,
            ),
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
          Icon(
            Icons.chat_bubble_outline,
            size: 48,
            color: ColorPalette.kBorder,
          ),
          SizedBox(height: 12),
          Text(
            'لا توجد ملاحظات بعد',
            style: TextStyle(color: ColorPalette.kkPrimaryGreen, fontSize: 14),
          ),
          SizedBox(height: 4),
          Text(
            'ابدأ أول ملاحظة في المجموعة',
            style: TextStyle(color: ColorPalette.kkPrimaryGreen, fontSize: 12),
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
      decoration: BoxDecoration(
        color: ColorPalette.kWhiteColor,
        border: Border(top: BorderSide(color: ColorPalette.kgrey300, width: 1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              constraints: const BoxConstraints(maxHeight: 120),
              decoration: BoxDecoration(
                color: ColorPalette.kgrey200,
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                controller: noteController,
                style: const TextStyle(color: ColorPalette.kBlackColor),
                minLines: 1,
                maxLines: 4,
                textInputAction: TextInputAction.send,
                onEditingComplete: () => _sendNote(context),
                decoration: const InputDecoration(
                  hintText: 'اكتب ملاحظة...',
                  hintStyle: TextStyle(color: ColorPalette.kPrimaryGray),
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
            color: ColorPalette.kSecondaryGreen,
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
