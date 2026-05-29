import 'package:flutter/material.dart';
import '../../data/models/payment_model.dart';

class PaymentMethodCard extends StatelessWidget {
  final PaymentMethod method;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentMethodCard({
    super.key,
    required this.method,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final data = _methodData[method]!;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? const Color(0xFF1D9E75) : const Color(0xFFE5E7EB),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 42, height: 42,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFE1F5EE) : const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(data.$3,
                color: isSelected ? const Color(0xFF1D9E75) : const Color(0xFF9CA3AF),
                size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(data.$1, style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w600,
                  color: isSelected ? const Color(0xFF1A1A2E) : const Color(0xFF374151),
                )),
                const SizedBox(height: 2),
                Text(data.$2, style: const TextStyle(fontSize: 12, color: Color(0xFF9CA3AF))),
              ]),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 20, height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xFF1D9E75) : const Color(0xFFD1D5DB),
                  width: isSelected ? 5.5 : 1.5,
                ),
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static const _methodData = {
    PaymentMethod.card: ('بطاقة ائتمانية / مدى', 'Visa, Mastercard, Meeza', Icons.credit_card_rounded),
    PaymentMethod.fawry: ('فوري', 'ادفع في أقرب نقطة فوري', Icons.storefront_rounded),
    PaymentMethod.valu: ('valU', 'التقسيط الأسهل', Icons.percent_rounded),
    PaymentMethod.meeza: ('ميزة', 'البطاقة الوطنية المصرية', Icons.account_balance_wallet_rounded),
  };
}
