import 'package:equatable/equatable.dart';
import 'package:myfarm/features/payment/data/models/payment_model.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();
  @override
  List<Object?> get props => [];
}

class PaymentInitial extends PaymentState {
  final PaymentMethod selectedMethod;
  const PaymentInitial({this.selectedMethod = PaymentMethod.card});
  @override
  List<Object?> get props => [selectedMethod];
}

class PaymentLoading extends PaymentState {}

class PaymentUrlReady extends PaymentState {
  final String iframeUrl;
  final int amountCents;
  final String currency;
  final PaymentMethod method;

  const PaymentUrlReady({
    required this.iframeUrl,
    required this.amountCents,
    required this.currency,
    required this.method,
  });

  @override
  List<Object?> get props => [iframeUrl, amountCents, currency, method];
}

class PaymentSuccess extends PaymentState {
  final String transactionId;
  const PaymentSuccess({required this.transactionId});
  @override
  List<Object?> get props => [transactionId];
}

class PaymentFailure extends PaymentState {
  final String message;
  const PaymentFailure({required this.message});
  @override
  List<Object?> get props => [message];
}