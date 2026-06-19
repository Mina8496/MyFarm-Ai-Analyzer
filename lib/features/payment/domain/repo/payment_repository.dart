import 'package:dartz/dartz.dart';
import 'package:myfarm/core/errors/failure.dart';
import 'package:myfarm/features/payment/data/models/payment_model.dart';

abstract class PaymentRepository {
  Future<Either<Failure, void>> savePayment(PaymentModel payment);
}
