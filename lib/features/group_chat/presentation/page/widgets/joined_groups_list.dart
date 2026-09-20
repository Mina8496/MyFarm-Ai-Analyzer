import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfarm/common/constants/color_palette.dart';
import 'package:myfarm/core/utils/styles.dart';
import 'package:myfarm/features/shared_notes/domain/entities/joined_group_entity.dart';
import 'package:myfarm/features/shared_notes/presentation/manger/notes_group_cubit.dart';
import 'package:myfarm/features/shared_notes/presentation/manger/notes_group_state.dart';

class JoinedGroupsList extends StatelessWidget {
  final bool busy;
  final void Function(String groupId) onTapGroup;

  const JoinedGroupsList({
    super.key,
    required this.busy,
    required this.onTapGroup,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesGroupCubit, NotesGroupState>(
      buildWhen: (previous, current) => current is NotesGroupInitial,
      builder: (context, state) {
        if (state is! NotesGroupInitial) return const SizedBox.shrink();
        if (state.joinedGroups.isEmpty && !state.loadingJoinedGroups) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Divider(color: ColorPalette.kBlackColor),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: Text('مجموعاتك', style: Styles.style16),
            ),
            const SizedBox(height: 8),
            if (state.loadingJoinedGroups)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              )
            else
              ...state.joinedGroups.map(
                (g) => _GroupTile(
                  group: g,
                  disabled: busy,
                  onTap: () => onTapGroup(g.id),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _GroupTile extends StatelessWidget {
  final JoinedGroupEntity group;
  final bool disabled;
  final VoidCallback onTap;

  const _GroupTile({
    required this.group,
    required this.disabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorPalette.kBlackColor.withValues(alpha: 0.03),
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: const Icon(Icons.groups, color: ColorPalette.kPrimaryGray),
        title: Text(group.name, style: Styles.style18),
        subtitle: Text('رقم المجموعة: ${group.id}', style: Styles.style16),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 14,
          color: ColorPalette.kSGreen,
        ),
        onTap: disabled ? null : onTap,
      ),
    );
  }
}