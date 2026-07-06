import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfarm/common/constants/color_palette.dart';
import 'package:myfarm/core/function/injection_container.dart';
import 'package:myfarm/core/storage/app_storage.dart';
import 'package:myfarm/features/Home/presentation/manger/home_cubit/main_nav_cubit.dart';
import 'package:myfarm/features/Home/presentation/view/widget/custom_bottom_bar.dart';
import 'package:myfarm/features/Home/presentation/view/widget/home_page_body.dart';
import 'package:myfarm/features/PlantTip/presentation/manger/plant_tips_cubit/plant_tips_cubit.dart';
import 'package:myfarm/features/account_menu_page/presentation/view/account_menu_page.dart';
import 'package:myfarm/features/tasks/presentation/view/role_selection_page.dart';
import 'package:myfarm/features/tasks/presentation/view/tasks_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final pages = [
    const HomePageBody(), // 0
    const SizedBox(),
    const HomeTasksEntryPage(), // 2
    const AccountMenuPage(), // 3
  ];
  // const MarketPage(),    // 1

  // 2
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MainNavCubit()),
        BlocProvider.value(value: getIt<PlantTipsCubit>()..init()),
        // BlocProvider(create: (_) => getIt<ProfilePage>()..init()),
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
              onPressed: () => context.read<MainNavCubit>().changePage(0),
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

class HomeTasksEntryPage extends StatelessWidget {
  const HomeTasksEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: AppStorage.getUserType(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final savedType = snapshot.data?.trim();
        if (savedType != null && savedType.isNotEmpty) {
          return TasksPage(role: userRoleFromFirebaseValue(savedType));
        }

        return const RoleSelectionPage();
      },
    );
  }
}
