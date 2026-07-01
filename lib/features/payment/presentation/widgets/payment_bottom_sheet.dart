import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfarm/features/payment/data/dataSource/payment_remote_data_source.dart';
import 'package:myfarm/features/payment/data/repositoryImp/payment_repository_impl.dart';
import 'package:myfarm/features/payment/domain/entities/billing_data.dart';
import 'package:myfarm/features/payment/domain/entities/order_Item.dart';
import 'package:myfarm/features/payment/presentation/manger/Bloc/payment_cubit.dart';
import 'package:myfarm/features/payment/presentation/screens/payment_screen.dart';

Future<void> showPaymentBottomSheet({
  required BuildContext context,
  required int amountCents,
  required BillingData billingData,
  List<OrderItem> items = const [],
  String currency = 'EGP',
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return BlocProvider(
        create: (_) => PaymentBloc(
          paymentRepository: PaymentRepositoryImpl(
            PaymentRemoteDataSourceImpl(
              FirebaseAuth.instance,
              FirebaseFirestore.instance,
            ),
          ),
        ),
        child: PaymentBottomSheet(
          amountCents: amountCents,
          billingData: billingData,
          items: items,
          currency: currency,
        ),
      );
    },
  );
}