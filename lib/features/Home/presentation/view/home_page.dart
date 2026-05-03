import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfarm/common/constants/color_palette.dart';
import 'package:myfarm/core/function/injection_container.dart';
import 'package:myfarm/features/Home/presentation/manger/cubit/main_nav_cubit.dart';
import 'package:myfarm/features/Home/presentation/view/widget/custom_bottom_bar.dart';
import 'package:myfarm/features/Home/presentation/view/widget/home_page_body.dart';
import 'package:myfarm/features/PlantTip/presentation/manger/plant_tips_cubit/plant_tips_cubit.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final pages = [
    const HomePageBody(),
    // const CommunityPage(),
    // const ScanPage(),
    // const PlantsPage(),
    // const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => MainNavCubit(),
        ),
        BlocProvider(
          create: (_) => getIt<PlantTipsCubit>()..init(),
        ),
      ],
      child: BlocBuilder<MainNavCubit, int>(
        builder: (context, currentIndex) {
          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              backgroundColor: ColorPalette.kkPrimaryGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onPressed: () => context.read<MainNavCubit>().changePage(2),
              child: Card(
                color: ColorPalette.kkPrimaryGreen,
                child: const Icon(
                  Icons.qr_code_scanner,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            body: pages[currentIndex],
            bottomNavigationBar: const CustomBottomBar(),
          );
        },
      ),
    );
  }
}