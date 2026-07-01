import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:myfarm/features/payment/data/models/payment_model.dart';
import 'package:myfarm/features/payment/domain/entities/billing_data.dart';
import 'package:myfarm/features/payment/domain/entities/order_Item.dart';
import 'package:myfarm/features/payment/presentation/manger/Bloc/payment_cubit.dart';
import 'package:myfarm/features/payment/presentation/manger/Bloc/payment_state.dart';
import 'package:myfarm/features/payment/presentation/manger/Bloc/paymente_event.dart';
import 'package:myfarm/features/payment/presentation/screens/payment_result_screen.dart';
import 'package:myfarm/features/payment/presentation/screens/paymob_webview_screen.dart';
import 'package:myfarm/features/payment/presentation/widgets/payment_method_card.dart';
import 'package:myfarm/features/payment/presentation/widgets/payment_summary_card.dart';

class PaymentBottomSheet extends StatelessWidget {
  final int amountCents;
  final BillingData billingData;
  final List<OrderItem> items;
  final String currency;

  const PaymentBottomSheet({
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
              child: PaymobWebViewScreen(
                iframeUrl: state.iframeUrl,
                amountCents: state.amountCents,
                currency: state.currency,
                method: state.method,
              ),
            ),
          );
        } else if (state is PaymentSuccess) {
          Navigator.pop(context);

          Get.off(
            () => PaymentResultScreen(
              success: true,
              transactionId: state.transactionId,
              amount: amountCents / 100,
              currency: currency,
            ),
          );
        } else if (state is PaymentFailure) {
          Navigator.pop(context);

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
      child: Container(
        height: MediaQuery.of(context).size.height * .88,
        decoration: const BoxDecoration(
          color: Color(0xFFF8F9FA),
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),

            Container(
              width: 45,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            Expanded(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  centerTitle: true,
                  automaticallyImplyLeading: false,
                  title: const Text(
                    "الدفع",
                    style: TextStyle(
                      color: Color(0xFF1A1A2E),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
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
                            children: const [PaymentMethod.card].map((method) {
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
          ],
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
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
