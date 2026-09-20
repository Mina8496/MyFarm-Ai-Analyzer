import 'package:flutter/material.dart';
import 'package:myfarm/common/constants/color_palette.dart';

class NoteBubble extends StatelessWidget {
  final String content;
  final String authorName;
  final String time;
  final bool isMine;
  final bool showName;
  final bool showAvatar;
  final Color avatarColor;
  final double topSpacing;

  const NoteBubble({
    super.key,
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
    final bubbleColor =
        isMine ? ColorPalette.kSecondaryGreen : ColorPalette.kWhiteColor;
    final textColor =
        isMine ? ColorPalette.kWhiteColor : ColorPalette.kkPrimaryGreen;
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