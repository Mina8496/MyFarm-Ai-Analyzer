import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfarm/common/constants/color_palette.dart';
import 'package:myfarm/core/utils/styles.dart';
import 'package:myfarm/features/shared_notes/domain/entities/joined_group_entity.dart';
import 'package:myfarm/features/shared_notes/presentation/manger/notes_group_cubit.dart';
import 'package:myfarm/features/shared_notes/presentation/manger/notes_group_state.dart';

class JoinedGroupsList extends StatefulWidget {
  final bool busy;
  final void Function(String groupId) onTapGroup;

  const JoinedGroupsList({
    super.key,
    required this.busy,
    required this.onTapGroup,
  });

  @override
  State<JoinedGroupsList> createState() => _JoinedGroupsListState();
}

class _JoinedGroupsListState extends State<JoinedGroupsList> {
  late Future<List<JoinedGroupEntity>> _future;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    _future = context.read<NotesGroupCubit>().loadJoinedGroups();
  }

  @override
  Widget build(BuildContext context) {
    // بيسمع أي رجوع لـ NotesGroupInitial (بعد إنشاء/انضمام ناجح ثم leave،
    // أو بعد ما الشاشة تفتح تاني) ويعيد تحميل القايمة من الـ local storage.
    return BlocListener<NotesGroupCubit, NotesGroupState>(
      listenWhen: (previous, current) => current is NotesGroupInitial,
      listener: (context, state) => setState(_reload),
      child: FutureBuilder<List<JoinedGroupEntity>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const SizedBox.shrink();
          }
          final groups = snapshot.data ?? const <JoinedGroupEntity>[];
          if (groups.isEmpty) return const SizedBox.shrink();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Divider(color: ColorPalette.kBlackColor),
              SizedBox(height: 8.h),
              Align(
                alignment: Alignment.centerRight,
                child: Text('مجموعاتك', style: Styles.style16),
              ),
              const SizedBox(height: 8),
              ...groups.map(
                (g) => Card(
                  color: ColorPalette.kBlackColor.withValues(alpha: 0.03),
                  margin: const EdgeInsets.only(bottom: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.groups,
                      color: ColorPalette.kPrimaryGray,
                    ),
                    title: Text(g.name, style: Styles.style18),
                    subtitle: Text(
                      'رقم المجموعة: ${g.id}',
                      style: Styles.style16,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: ColorPalette.kSGreen,
                    ),
                    onTap: widget.busy ? null : () => widget.onTapGroup(g.id),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}