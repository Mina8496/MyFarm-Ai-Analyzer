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
  final List notes;
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

  // لون ثابت لكل اسم (زي واتساب لما مفيش صورة بروفايل)
  static const List<Color> _avatarPalette = [
    Color(0xFFE57373),
    Color(0xFF64B5F6),
    Color(0xFF81C784),
    Color(0xFFFFB74D),
    Color.fromARGB(255, 194, 135, 205),
    Color(0xFF4DB6AC),
    Color(0xFFF06292),
    Color(0xFF9575CD),
    Color(0xFFA1887F),
  ];

  Color _colorForName(String name) {
    if (name.isEmpty) return _avatarPalette.first;
    final index = name.hashCode.abs() % _avatarPalette.length;
    return _avatarPalette[index];
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
                  padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final note = notes[index];
                    final isMine = note.authorName == currentUserName;

                    final olderNote = index + 1 < notes.length
                        ? notes[index + 1]
                        : null;
                    final newerNote = index - 1 >= 0 ? notes[index - 1] : null;

                    final isFirstInGroup =
                        olderNote == null ||
                        olderNote.authorName != note.authorName;
                    final isLastInGroup =
                        newerNote == null ||
                        newerNote.authorName != note.authorName;

                    return _NoteBubble(
                      content: note.content,
                      authorName: note.authorName,
                      time: _formatTime(note.createdAt),
                      isMine: isMine,
                      showName: isFirstInGroup && !isMine,
                      showAvatar: isLastInGroup && !isMine,
                      avatarColor: _colorForName(note.authorName),
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
            onPressed: () => context.read<NotesGroupCubit>().leaveGroup(),
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
      // خلفية بيضا واضحة + حد علوي رمادي فاتح ظاهر، بدل نفس لون
      // الخلفية اللي كان بيلغي الحدود خالص.
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
                // نص أسود واضح فوق خلفية رمادي فاتح، بدل أخضر فاتح
                // على خلفية فاتحة قريبة منه في اللون.
                style: const TextStyle(color: ColorPalette.kBlackColor),
                minLines: 1,
                maxLines: 4,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _sendNote(context),
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

class _NoteBubble extends StatelessWidget {
  final String content;
  final String authorName;
  final String time;
  final bool isMine;
  final bool showName;
  final bool showAvatar;
  final Color avatarColor;
  final double topSpacing;

  const _NoteBubble({
    required this.content,
    required this.authorName,
    required this.time,
    required this.isMine,
    required this.showName,
    required this.showAvatar,
    required this.avatarColor,
    required this.topSpacing,
  });

  @override
  Widget build(BuildContext context) {
    // رسايلي: أخضر واضح زي واتساب بالظبط + نص أبيض.
    // رسايل التانيين: فقاعة بيضا واضحة + نص غامق — زي واتساب تمامًا.
    final bubbleColor = isMine
        ? ColorPalette.kSecondaryGreen
        : ColorPalette.kWhiteColor;
    final textColor = isMine
        ? ColorPalette.kWhiteColor
        : ColorPalette.kkPrimaryGreen;
    final timeColor = isMine
        ? ColorPalette.kWhiteColor.withValues(alpha: 0.75)
        : ColorPalette.kPrimaryGray;

    final bubbleContent = Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.72,
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
          boxShadow: [
            BoxShadow(
              color: ColorPalette.kBlackColor.withValues(alpha: 0.06),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showName)
              Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(
                  authorName,
                  style: TextStyle(
                    color: avatarColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            Text(
              content,
              textAlign: TextAlign.right,
              style: TextStyle(color: textColor, fontSize: 14),
            ),
            const SizedBox(height: 3),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                time,
                style: TextStyle(color: timeColor, fontSize: 10),
              ),
            ),
          ],
        ),
      ),
    );

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: EdgeInsets.only(top: topSpacing, bottom: 2),
        child: isMine
            ? Align(alignment: Alignment.centerRight, child: bubbleContent)
            : Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 30,
                    child: showAvatar
                        ? CircleAvatar(
                            radius: 14,
                            backgroundColor: avatarColor,
                            child: Text(
                              authorName.isNotEmpty
                                  ? authorName.characters.first.toUpperCase()
                                  : '?',
                              style: const TextStyle(
                                // أبيض ثابت بدل kcardGreen، عشان يفضل
                                // مقروء فوق أي لون عشوائي من الـ palette.
                                color: ColorPalette.kWhiteColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(width: 6),
                  Flexible(child: bubbleContent),
                ],
              ),
      ),
    );
  }
}
