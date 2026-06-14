import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfarm/features/payment/domain/entities/billing_data.dart';
import 'package:myfarm/features/payment/domain/entities/order_Item.dart';
import 'package:myfarm/features/payment/presentation/manger/Bloc/payment_cubit.dart';
import 'package:myfarm/features/payment/presentation/manger/Bloc/payment_state.dart';
import 'package:myfarm/features/payment/presentation/manger/Bloc/paymente_event.dart';
import '../../data/models/payment_model.dart';
import '../widgets/payment_method_card.dart';
import '../widgets/payment_summary_card.dart';
import 'paymob_webview_screen.dart';
import 'payment_result_screen.dart';
import 'package:get/get.dart';
// ─── Payment Screen ───────────────────────────────────────────────
// الشاشة الرئيسية للدفع — يُمرر إليها amount و billingData و items
// ─────────────────────────────────────────────────────────────────

class PaymentScreen extends StatelessWidget {
  final int amountCents;
  final BillingData billingData;
  final List<OrderItem> items;
  final String currency;

  const PaymentScreen({
  super.key,
  required this.amountCents,
  this.billingData = const BillingData(
    firstName: 'عميل',
    lastName: 'تجريبي',
    email: 'cliente@example.com',
    city: "القاهرة",
    country: "EG",
    phone: '01000000000',
    ),
  this.items = const [],
  this.currency = 'EGP',
});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PaymentBloc(),
      child: _PaymentScreenContent(
        amountCents: amountCents,
        billingData: billingData,
        items: items,
        currency: currency,
      ),
    );
  }
}

class _PaymentScreenContent extends StatelessWidget {
  final int amountCents;
  final BillingData billingData;
  final List<OrderItem> items;
  final String currency;

  const _PaymentScreenContent({
    required this.amountCents,
    required this.billingData,
    required this.items,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentBloc, PaymentState>(
      listener: (context, state) {
  if (state is PaymentUrlReady) {
    Get.to(
      () => BlocProvider.value(
        value: context.read<PaymentBloc>(),
        child: PaymobWebViewScreen(iframeUrl: state.iframeUrl),
      ),
    );
  } else if (state is PaymentSuccess) {
    Get.off(
      () => PaymentResultScreen(
        success: true,
        transactionId: state.transactionId,
        amount: amountCents / 100,
        currency: currency,
      ),
    );
  } else if (state is PaymentFailure) {
    Get.off(
      () => PaymentResultScreen(
        success: false,
        message: state.message,
        amount: amountCents / 100,
        currency: currency,
      ),
    );
  }
},
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'الدفع',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A2E),
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                size: 20, color: Color(0xFF1A1A2E)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(height: 1, color: const Color(0xFFEEEEEE)),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),

                // ملخص الطلب
                PaymentSummaryCard(
                  amountCents: amountCents,
                  currency: currency,
                  items: items,
                ),
                const SizedBox(height: 28),

                const Text(
                  'طريقة الدفع',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
                const SizedBox(height: 12),

                // اختيار طريقة الدفع
                BlocBuilder<PaymentBloc, PaymentState>(
                  builder: (context, state) {
                    final selected = state is PaymentInitial
                        ? state.selectedMethod
                        : PaymentMethod.card;

                    return Column(
                      children: PaymentMethod.values.map((method) {
                        return PaymentMethodCard(
                          method: method,
                          isSelected: selected == method,
                          onTap: () => context.read<PaymentBloc>().add(
                            SelectPaymentMethodEvent(method),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),

                const Spacer(),

                // زرار الدفع
                BlocBuilder<PaymentBloc, PaymentState>(
                  builder: (context, state) {
                    final isLoading = state is PaymentLoading;
                    final selectedMethod = state is PaymentInitial
                        ? state.selectedMethod
                        : PaymentMethod.card;

                    return _PayButton(
                      amountCents: amountCents,
                      currency: currency,
                      isLoading: isLoading,
                      onPressed: isLoading
                          ? null
                          : () {
                              context.read<PaymentBloc>().add(
                                InitiatePaymentEvent(
                                  amountCents: amountCents,
                                  billingData: billingData,
                                  items: items,
                                  method: selectedMethod,
                                  currency: currency,
                                ),
                              );
                            },
                    );
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PayButton extends StatelessWidget {
  final int amountCents;
  final String currency;
  final bool isLoading;
  final VoidCallback? onPressed;

  const _PayButton({
    required this.amountCents,
    required this.currency,
    required this.isLoading,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1D9E75),
          disabledBackgroundColor: const Color(0xFF1D9E75).withOpacity(0.6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              )
            : Text(
                'ادفع ${(amountCents / 100).toStringAsFixed(2)} $currency',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 0.3,
                ),
              ),
      ),
    );
  }
}
