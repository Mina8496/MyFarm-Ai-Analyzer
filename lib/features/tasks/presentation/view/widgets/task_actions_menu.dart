import 'package:flutter/material.dart';
import 'package:myfarm/common/constants/color_palette.dart';
import 'package:myfarm/core/utils/styles.dart';

class TaskActionsMenu extends StatelessWidget {
  final bool canEdit;
  final bool canDelete;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const TaskActionsMenu({
    super.key,
    required this.canEdit,
    required this.canDelete,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, color: ColorPalette.kGreen, size: 18),
      color: ColorPalette.kkPrimaryGreen,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onSelected: (value) {
        if (value == 'edit' && onEdit != null) {
          onEdit!();
        } else if (value == 'delete' && onDelete != null) {
          onDelete!();
        }
      },
      itemBuilder: (_) => [
        if (canEdit)
          PopupMenuItem(
            value: 'edit',
            child: Row(
              children: [
                const Icon(
                  Icons.edit_outlined,
                  color: ColorPalette.kLightGreen,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  'تعديل',
                  style: Styles.style14.copyWith(
                    color: ColorPalette.kWhiteColor,
                  ),
                ),
              ],
            ),
          ),
        if (canDelete)
          PopupMenuItem(
            value: 'delete',
            child: Row(
              children: [
                const Icon(
                  Icons.delete_outline,
                  color: ColorPalette.kLightRed,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  'حذف',
                  style: Styles.style14.copyWith(color: ColorPalette.kLightRed),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
