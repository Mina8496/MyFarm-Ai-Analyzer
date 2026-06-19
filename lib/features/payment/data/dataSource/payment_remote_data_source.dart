import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:myfarm/features/payment/data/models/payment_model.dart';

abstract class PaymentRemoteDataSource {
  /// يسجل الدفعة (success أو failed) في:
  /// users/{uid}/payments/{paymentId}
  Future<void> savePayment(PaymentModel payment);
}

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  final fb.FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const PaymentRemoteDataSourceImpl(this.auth, this.firestore);

  @override
  Future<void> savePayment(PaymentModel payment) async {
    final user = auth.currentUser;
    if (user == null) {
      throw StateError('لا يمكن تسجيل عملية الدفع: المستخدم غير مسجل دخول');
    }

    await firestore
        .collection('users')
        .doc(user.uid)
        .collection('payments')
        .doc(payment.id)
        .set(payment.toJson());
  }
}
