import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:myfarm/features/plant_analysis/Presentation/Binding/OnboardingBinding.dart';
import 'package:myfarm/features/plant_analysis/Presentation/Binding/PlantAnalysisBinding.dart';
import 'package:myfarm/features/plant_analysis/Presentation/Pages/Login/login_page.dart';
import 'package:myfarm/features/plant_analysis/Presentation/Pages/PageView/onBoarding_Page.dart';
import 'package:myfarm/features/plant_analysis/Presentation/Pages/home/PlantAnalysisPage.dart';
import 'package:myfarm/features/plant_analysis/Presentation/Pages/home/home_shell.dart';
import 'package:myfarm/features/plant_analysis/Presentation/Pages/splash_body.dart';
import 'package:myfarm/features/plant_analysis/Presentation/Pages/user_type_page.dart';

class AppPages {
  static final pages = [
    GetPage(name: '/splash', page: () => const SplashViewBody()),
    GetPage(
      name: '/onboarding',
      page: () => const OnboardingPage(),
      binding: OnboardingBinding(),
    ),

    GetPage(name: '/user_type', page: () => UserTypeSelectionPage()),
    GetPage(name: '/homeMain', page: () => HomeMainShell()),
    GetPage(name: '/login', page: () => LoginPage()),
    GetPage(
      name: '/plant-analysis',
      page: () => const PlantAnalysisPage(),
      binding: PlantAnalysisBinding(),
    ),
  ];
}
