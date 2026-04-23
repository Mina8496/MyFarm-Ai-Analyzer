import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfarm/common/constants/color_palette.dart';
import 'package:myfarm/core/widgets/app_textView.dart';
import 'package:myfarm/features/Subscription_Paywall/presentation/ViewModel/subscription_planModel.dart';

class PlanCard extends StatelessWidget {
  final PlanViewModel plan;
  final bool isSelected;

  const PlanCard({super.key, required this.plan, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ColorPalette.kgrey200,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isSelected
              ? ColorPalette.kkPrimaryGreen
              : ColorPalette.kgrey300,
          width: 2,
        ),
      ),
      child: Stack(
        children: [
          _CheckIcon(isSelected: isSelected),
          _PlanContent(plan: plan),
        ],
      ),
    );
  }
}

// CheckIcon
class _CheckIcon extends StatelessWidget {
  final bool isSelected;

  const _CheckIcon({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? ColorPalette.kkPrimaryGreen : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          Icons.check,
          size: 16,
          color: isSelected ? ColorPalette.kPrimaryColor : Colors.transparent,
        ),
      ),
    );
  }
}

class _PlanContent extends StatelessWidget {
  final PlanViewModel plan;

  const _PlanContent({required this.plan});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppText(text: plan.title, fontSize: 13.sp, fontWeight: FontWeight.w500),
        const SizedBox(height: 8),
        Text(
          plan.price,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          plan.duration,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    );
  }
}
