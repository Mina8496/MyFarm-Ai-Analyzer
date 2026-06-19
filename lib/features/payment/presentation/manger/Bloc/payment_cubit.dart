import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfarm/core/network/paymob_client.dart';
import 'package:myfarm/core/services/paymob_service.dart';
import 'package:myfarm/features/payment/data/models/payment_model.dart';
import 'package:myfarm/features/payment/domain/repo/payment_repository.dart';
import 'package:myfarm/features/payment/presentation/manger/Bloc/payment_state.dart';
import 'package:myfarm/features/payment/presentation/manger/Bloc/paymente_event.dart';
import 'package:uuid/uuid.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymobService _service;
  final PaymentRepository _paymentRepository;
  static const _uuid = Uuid();

  PaymentBloc({
    PaymobService? service,
    required PaymentRepository paymentRepository,
  }) : _service = service ?? PaymobService(),
       _paymentRepository = paymentRepository,
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
      emit(
        PaymentUrlReady(
          iframeUrl: url,
          amountCents: event.amountCents,
          currency: event.currency,
          method: event.method,
        ),
      );
    } on PaymobApiException catch (e) {
      emit(PaymentFailure(message: e.message));
    } catch (_) {
      emit(const PaymentFailure(message: 'حدث خطأ غير متوقع'));
    }
  }

  Future<void> _onPaymentSucceeded(
    PaymentSucceededEvent event,
    Emitter<PaymentState> emit,
  ) async {
    final payment = PaymentModel(
      id: _uuid.v4(),
      amount: event.amountCents / 100,
      currency: event.currency,
      status: PaymentStatus.success,
      method: event.method,
      createdAt: DateTime.now(),
      transactionId: event.transactionId,
    );

    // تسجيل الدفعة في Firestore. لو فشل التسجيل، الـ UI لسه بيعتبر
    // الدفع ناجح (الفلوس اتحصلت فعليًا)، بس بنطبع الخطأ كـ تنبيه فقط.
    final result = await _paymentRepository.savePayment(payment);
    result.fold((failure) {
      // ignore: avoid_print
      print('فشل تسجيل عملية الدفع الناجحة: ${failure.message}');
    }, (_) {});

    emit(PaymentSuccess(transactionId: event.transactionId));
  }

  Future<void> _onPaymentFailed(
    PaymentFailedEvent event,
    Emitter<PaymentState> emit,
  ) async {
    final payment = PaymentModel(
      id: _uuid.v4(),
      amount: event.amountCents / 100,
      currency: event.currency,
      status: PaymentStatus.failed,
      method: event.method,
      createdAt: DateTime.now(),
      errorMessage: event.reason,
    );

    final result = await _paymentRepository.savePayment(payment);
    result.fold((failure) {
      // ignore: avoid_print
      print('فشل تسجيل عملية الدفع الفاشلة: ${failure.message}');
    }, (_) {});

    emit(PaymentFailure(message: event.reason));
  }

  void _onSelectMethod(
    SelectPaymentMethodEvent event,
    Emitter<PaymentState> emit,
  ) => emit(PaymentInitial(selectedMethod: event.method));

  void _onReset(ResetPaymentEvent event, Emitter<PaymentState> emit) =>
      emit(const PaymentInitial());
}
