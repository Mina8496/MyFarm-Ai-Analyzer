import 'package:get/get.dart';
import 'package:myfarm/features/Home/presentation/view/home_page.dart';
import 'package:myfarm/features/Home/presentation/view/widget/plantTips.dart';
import 'package:myfarm/features/PlantTip/presentation/Binding/PlantTipsBinding.dart';
import 'package:myfarm/features/boarding/presentation/binding/OnboardingBinding.dart';
import 'package:myfarm/features/forget_password/presentation/view/forget_password.dart';
import 'package:myfarm/features/plant_analysis/Presentation/Binding/PlantAnalysisBinding.dart';
import 'package:myfarm/features/login/presentation/view/login_page.dart';
import 'package:myfarm/features/signup/presentation/Binding/signup_binding.dart';
import 'package:myfarm/features/signup/presentation/view/signup_page.dart';
import 'package:myfarm/features/boarding/presentation/views/onBoarding_Page.dart';
import 'package:myfarm/features/homeMain/PlantAnalysisPage.dart';
import 'package:myfarm/features/splah/presentation/views/splash_view.dart';
import 'package:myfarm/features/UserType/presentation/views/userType_selection_page.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: '/splash',
      page: () => const SplashView(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: '/onboarding',
      page: () => const OnboardingPage(),
      binding: OnboardingBinding(),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: '/user_type',
      page: () => UserTypeSelectionPage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: '/home',
      page: () => HomePage(),
      binding: PlantTipsBinding(),
      transition: Transition.upToDown,
    ),
    /*
    GetPage(
      name: '/homeMain',
      page: () => HomeMainShell(),
      transition: Transition.upToDown,
    ),
    */
    GetPage(name: '/tips', page: () => PlantTips()),
    GetPage(
      name: '/login',
      page: () => LoginPage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: '/signup',
      page: () => const SignupPage(),
      binding: SignupBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: '/forgetpassword',
      page: () => const ForgetPassword(),
      transition: Transition.topLevel,
    ),
    GetPage(
      name: '/plant-analysis',
      page: () => const PlantAnalysisPage(),
      binding: PlantAnalysisBinding(),
    ),
  ];
}
