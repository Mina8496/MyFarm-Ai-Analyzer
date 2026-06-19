import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfarm/features/Subscription_Paywall/presentation/Widget/Video_header.dart';
import 'package:myfarm/features/Subscription_Paywall/presentation/Widget/bottom_panel.dart';
import 'package:myfarm/features/Subscription_Paywall/presentation/Widget/subscripion_header.dart';
import 'package:myfarm/features/Subscription_Paywall/presentation/manger/cubit/subscription_page_cubit.dart';

class SubscriptionPageBody extends StatefulWidget {
  const SubscriptionPageBody({super.key});

  @override
  State<SubscriptionPageBody> createState() => _SubscriptionPageBodyState();
}

class _SubscriptionPageBodyState extends State<SubscriptionPageBody> {
  late final SubscriptionCubit cubit;
  @override
  void initState() {
    super.initState();
    cubit = SubscriptionCubit();
  }

  @override
  void dispose() {
    debugPrint('SubscriptionPageBody disposed');
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Stack(
        children: [
          ///  Background Video
          const VideoHeader(),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.7),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: Stack(
              children: [
                const SubscripionHeader(),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: BottomPanel(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
