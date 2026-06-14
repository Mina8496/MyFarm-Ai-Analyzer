import 'package:flutter/material.dart';
import 'package:myfarm/features/payment/domain/entities/order_Item.dart';

class PaymentSummaryCard extends StatelessWidget {
  final int amountCents;
  final String currency;
  final List<OrderItem> items;

  const PaymentSummaryCard({
    super.key, required this.amountCents, required this.currency, required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        children: [
          ...items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(item.name, style: const TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
                Text('${(item.amount / 100).toStringAsFixed(2)} $currency',
                    style: const TextStyle(fontSize: 14, color: Color(0xFF374151))),
              ],
            ),
          )),
          const Divider(height: 20, color: Color(0xFFE5E7EB)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('الإجمالي', style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF1A1A2E))),
              Text('${(amountCents / 100).toStringAsFixed(2)} $currency',
                  style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF1D9E75))),
            ],
          ),
        ],
      ),
    );
  }
}
