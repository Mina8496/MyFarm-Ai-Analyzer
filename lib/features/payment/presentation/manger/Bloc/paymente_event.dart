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
  final int amountCents;
  final String currency;
  final PaymentMethod method;

  const PaymentSucceededEvent({
    required this.transactionId,
    required this.amountCents,
    required this.currency,
    required this.method,
  });

  @override
  List<Object?> get props => [transactionId, amountCents, currency, method];
}

class PaymentFailedEvent extends PaymentEvent {
  final String reason;
  final int amountCents;
  final String currency;
  final PaymentMethod method;

  const PaymentFailedEvent({
    required this.reason,
    required this.amountCents,
    required this.currency,
    required this.method,
  });

  @override
  List<Object?> get props => [reason, amountCents, currency, method];
}

class SelectPaymentMethodEvent extends PaymentEvent {
  final PaymentMethod method;
  const SelectPaymentMethodEvent(this.method);
  @override
  List<Object?> get props => [method];
}

class ResetPaymentEvent extends PaymentEvent {}
