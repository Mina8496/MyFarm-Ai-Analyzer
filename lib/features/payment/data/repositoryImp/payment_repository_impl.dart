import 'package:dartz/dartz.dart';
import 'package:myfarm/core/errors/failure.dart';
import 'package:myfarm/core/errors/firebase_exception_mapper.dart';
import 'package:myfarm/features/payment/data/dataSource/payment_remote_data_source.dart';
import 'package:myfarm/features/payment/data/models/payment_model.dart';
import 'package:myfarm/features/payment/domain/repo/payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDataSource remote;
  const PaymentRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, void>> savePayment(PaymentModel payment) async {
    try {
      await remote.savePayment(payment);
      return const Right(null);
    } catch (e) {
      // FirebaseExceptionMapper.map بيرجع Failure مباشرة (مش يلفها),
      // وبيتعامل مع FirebaseAuthException و FirebaseException و أي error تاني.
      return Left(FirebaseExceptionMapper.map(e));
    }
  }
}