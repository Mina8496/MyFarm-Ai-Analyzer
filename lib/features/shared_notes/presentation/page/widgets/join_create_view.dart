import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfarm/common/constants/color_palette.dart';
import 'package:myfarm/core/auth/presentation/cubit/auth_cubit.dart';
import 'package:myfarm/core/auth/presentation/cubit/auth_state.dart';
import 'package:myfarm/core/utils/styles.dart';
import 'package:myfarm/core/widgets/app_text_feild.dart';
import 'package:myfarm/core/widgets/auth_required_dialog.dart';
import 'package:myfarm/features/shared_notes/presentation/manger/notes_group_cubit.dart';
import 'package:myfarm/features/shared_notes/presentation/page/widgets/joined_groups_list.dart';

class JoinCreateView extends StatelessWidget {
  final TextEditingController joinController;
  final TextEditingController nameController;
  final bool busy;

  const JoinCreateView({
    super.key,
    required this.joinController,
    required this.nameController,
    required this.busy,
  });

/// بيرجع true لو المستخدم مسجل دخول، وبيعرض الديالوج ويرجع false لو لأ.
  /// مفيش أي استيراد لـ firebase_auth هنا — القرار مبني على AuthCubit بس.
  bool _requireAuth(BuildContext context) {
    final isAuthenticated =
        context.read<AuthCubit>().state is AuthAuthenticated;
    if (!isAuthenticated) {
      AuthRequiredDialog.show(context, message: 'يجب تسجيل الدخول أولاً.');
    }
    return isAuthenticated;
  }

  void _createGroup(BuildContext context) {
    if (!_requireAuth(context)) return;
    context.read<NotesGroupCubit>().createGroup(nameController.text);
    nameController.clear();
  }

  void _join(BuildContext context, {String? groupId}) {
    if (!_requireAuth(context)) return;
    context.read<NotesGroupCubit>().joinGroup(groupId ?? joinController.text);
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        24,
        20,
        24 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHero(),
            const SizedBox(height: 28),
            _buildSectionCard(
              icon: Icons.group_add_outlined,
              title: 'إنشاء مجموعة جديدة',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppTextField(
                    controller: nameController,
                    hint: 'اسم المجموعة (اختياري)',
                  ),
                  SizedBox(height: 14.h),
                  _PrimaryButton(
                    label: 'إنشاء مجموعة',
                    icon: Icons.group_add,
                    onPressed: busy ? null : () => _createGroup(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildOrDivider(),
            const SizedBox(height: 16),
            _buildSectionCard(
              icon: Icons.login_outlined,
              title: 'الانضمام لمجموعة موجودة',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: joinController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    textInputAction: TextInputAction.done,
                    onSubmitted: busy ? null : (_) => _join(context),
                    style: const TextStyle(
                      color: ColorPalette.kBlackColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                    decoration: InputDecoration(
                      hintText: '000000',
                      hintStyle: const TextStyle(
                        color: ColorPalette.kPrimaryGray,
                        letterSpacing: 2,
                      ),
                      filled: true,
                      fillColor: Colors.black.withValues(alpha: 0.06),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                  const SizedBox(height: 14),
                  _SecondaryButton(
                    label: 'انضمام',
                    icon: Icons.arrow_forward,
                    onPressed: busy ? null : () => _join(context),
                  ),
                ],
              ),
            ),
            if (busy)
              const Padding(
                padding: EdgeInsets.only(top: 24),
                child: Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2.5),
                  ),
                ),
              ),
            const SizedBox(height: 12),
            JoinedGroupsList(
              busy: busy,
              onTapGroup: (id) => _join(context, groupId: id),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHero() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: ColorPalette.kBorder.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.groups_outlined,
            size: 40,
            color: ColorPalette.kBorder,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'شارك ملاحظات مع فريقك',
          textAlign: TextAlign.center,
          style: Styles.style20.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Text(
          'أنشئ مجموعة جديدة أو انضم لمجموعة برقمها',
          textAlign: TextAlign.center,
          style: Styles.style16,
        ),
      ],
    );
  }

  Widget _buildSectionCard({
    required IconData icon,
    required String title,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(icon, size: 18.sp, color: Colors.black),
              const SizedBox(width: 8),
              Text(title, style: Styles.style16),
            ],
          ),
          SizedBox(height: 14.h),
          child,
        ],
      ),
    );
  }

  Widget _buildOrDivider() {
    return const Row(
      children: [
        Expanded(child: Divider(color: ColorPalette.kBlackColor)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'أو',
            style: TextStyle(color: ColorPalette.kBlackColor, fontSize: 18),
          ),
        ),
        Expanded(child: Divider(color: ColorPalette.kBlackColor)),
      ],
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onPressed;

  const _PrimaryButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 20),
        label: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          disabledBackgroundColor: Colors.teal.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
      ),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onPressed;

  const _SecondaryButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 18),
        label: Text(label, style: Styles.style18),
        style: OutlinedButton.styleFrom(
          foregroundColor: ColorPalette.kBorder,
          side: BorderSide(
            color: ColorPalette.kBlackColor.withValues(alpha: 0.3),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
