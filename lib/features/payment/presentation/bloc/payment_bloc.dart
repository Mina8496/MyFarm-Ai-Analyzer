import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/payment_model.dart';
import '../../../../core/services/paymob_service.dart';
import '../../../../../core/network/paymob_client.dart';

// ════════════════════════════════════════════════════════════════
//  EVENTS
// ════════════════════════════════════════════════════════════════

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

// ════════════════════════════════════════════════════════════════
//  STATES
// ════════════════════════════════════════════════════════════════

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
  const PaymentUrlReady({required this.iframeUrl});
  @override
  List<Object?> get props => [iframeUrl];
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

// ════════════════════════════════════════════════════════════════
//  BLOC
// ════════════════════════════════════════════════════════════════

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymobService _service;

  PaymentBloc({PaymobService? service})
      : _service = service ?? PaymobService(),
        super(const PaymentInitial()) {
    on<InitiatePaymentEvent>(_onInitiatePayment);
    on<PaymentSucceededEvent>(_onPaymentSucceeded);
    on<PaymentFailedEvent>(_onPaymentFailed);
    on<SelectPaymentMethodEvent>(_onSelectMethod);
    on<ResetPaymentEvent>(_onReset);
  }

  Future<void> _onInitiatePayment(
    InitiatePaymentEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentLoading());
    try {
      final url = await _service.initPayment(
        amountCents: event.amountCents,
        billingData: event.billingData,
      );
      emit(PaymentUrlReady(iframeUrl: url));
    } on PaymobApiException catch (e) {
      emit(PaymentFailure(message: e.message));
    } catch (_) {
      emit(const PaymentFailure(message: 'حدث خطأ غير متوقع'));
    }
  }

  void _onPaymentSucceeded(
    PaymentSucceededEvent event,
    Emitter<PaymentState> emit,
  ) => emit(PaymentSuccess(transactionId: event.transactionId));

  void _onPaymentFailed(
    PaymentFailedEvent event,
    Emitter<PaymentState> emit,
  ) => emit(PaymentFailure(message: event.reason));

  void _onSelectMethod(
    SelectPaymentMethodEvent event,
    Emitter<PaymentState> emit,
  ) => emit(PaymentInitial(selectedMethod: event.method));

  void _onReset(ResetPaymentEvent event, Emitter<PaymentState> emit) =>
      emit(const PaymentInitial());
}
