import 'package:equatable/equatable.dart';
import 'package:myfarm/features/payment/data/models/payment_model.dart';
import 'package:myfarm/features/payment/domain/entities/billing_data.dart';
import 'package:myfarm/features/payment/domain/entities/order_Item.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();
  @override
  List<Object?> get props => [];
}

class InitiatePaymentEvent extends PaymentEvent {
  final int amountCents;
  final BillingData billingData;
  final List<OrderItem> items;
  final PaymentMethod method;
  final String currency;

  const InitiatePaymentEvent({
    required this.amountCents,
    required this.billingData,
    required this.items,
    this.method = PaymentMethod.card,
    this.currency = 'EGP',
  });

  @override
  List<Object?> get props => [amountCents, method, currency];
}

class PaymentSucceededEvent extends PaymentEvent {
  final String transactionId;
  const PaymentSucceededEvent({required this.transactionId});
  @override
  List<Object?> get props => [transactionId];
}

class PaymentFailedEvent extends PaymentEvent {
  final String reason;
  const PaymentFailedEvent({required this.reason});
  @override
  List<Object?> get props => [reason];
}

class SelectPaymentMethodEvent extends PaymentEvent {
  final PaymentMethod method;
  const SelectPaymentMethodEvent(this.method);
  @override
  List<Object?> get props => [method];
}

class ResetPaymentEvent extends PaymentEvent {}
