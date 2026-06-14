import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfarm/core/network/paymob_client.dart';
import 'package:myfarm/core/services/paymob_service.dart';
import 'package:myfarm/features/payment/presentation/manger/Bloc/payment_state.dart';
import 'package:myfarm/features/payment/presentation/manger/Bloc/paymente_event.dart';

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
