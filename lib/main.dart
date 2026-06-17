import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myfarm/app_config.dart';
import 'package:myfarm/common/constants/color_palette.dart';
import 'package:myfarm/core/auth/presentation/cubit/auth_cubit.dart';
import 'package:myfarm/core/function/injection_container.dart';
import 'package:myfarm/core/localization/app_translations.dart';
import 'package:myfarm/core/utils/routes/app_pages.dart';
import 'package:myfarm/features/PlantTip/data/dataSource/plantTips_local_data_source.dart';
import 'package:myfarm/features/PlantTip/data/model/plantTip_model.dart';
import 'package:myfarm/features/boarding/manger/cubit/onboarding_cubit_cubit.dart';
import 'package:myfarm/features/plant_analysis/Presentation/Binding/InitialBinding.dart';
import 'package:myfarm/features/tasks/data/model/task_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Hive init
  await Hive.initFlutter();
  Hive.registerAdapter(PlantTipModelAdapter());
  Hive.registerAdapter(TaskModelAdapter());
  await PlantTipsLocalDataSource.openBox();
  await Firebase.initializeApp();
  setupDependencies();
  AppConfig.lang =
      WidgetsBinding.instance.platformDispatcher.locale.languageCode;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => getIt<AuthCubit>()),
            BlocProvider(create: (_) => getIt<OnboardingCubit>()),
          ],
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light().copyWith(
              scaffoldBackgroundColor: ColorPalette.kPrimaryColor,
              useMaterial3: true,
            ),
            translations: AppTranslations(),
            locale: Get.deviceLocale,
            initialBinding: InitialBinding(),
            initialRoute: '/splash',
            getPages: AppPages.pages,
          ),
        );
      },
    );
  }
}
