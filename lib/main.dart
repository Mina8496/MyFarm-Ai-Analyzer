import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:myfarm/app_config.dart';
import 'package:myfarm/common/constants/color_palette.dart';
import 'package:myfarm/core/auth/presentation/cubit/auth_cubit.dart';
import 'package:myfarm/core/function/injection_container.dart';
import 'package:myfarm/core/localization/app_translations.dart';
import 'package:myfarm/core/utils/routes/app_pages.dart';
import 'package:myfarm/features/Home/data/datasources/weather_local_datasource.dart';
import 'package:myfarm/features/PlantTip/data/dataSource/plantTips_local_data_source.dart';
import 'package:myfarm/features/PlantTip/data/model/plantTip_model.dart';
import 'package:myfarm/features/ambient_screen/presentation/bindings/ambient_binding.dart';
import 'package:myfarm/features/ambient_screen/presentation/view/ambient_screen_page.dart';
import 'package:myfarm/features/boarding/manger/cubit/onboarding_cubit_cubit.dart';
import 'package:myfarm/features/plant_analysis/Presentation/Binding/InitialBinding.dart';
import 'package:myfarm/features/tasks/data/model/task_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initializeApp();

  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> ambientMain() async {
  WidgetsFlutterBinding.ensureInitialized();

  debugPrint('🟢 ambientMain() started');

  await Hive.initFlutter();

  await WeatherLocalDataSource.openBox();
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.example.app.channel.audio',
    androidNotificationChannelName: 'تشغيل الراديو',
    androidNotificationOngoing: true,
    androidStopForegroundOnPause: true,
  );

  runApp(const AmbientOnlyApp());
}

class AmbientOnlyApp extends StatelessWidget {
  const AmbientOnlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialBinding: AmbientBinding(),
          home: const AmbientScreenPage(),
        );
      },
    );
  }
}

Future<void> _initializeApp() async {
  await Hive.initFlutter();

  Hive.registerAdapter(PlantTipModelAdapter());
  Hive.registerAdapter(TaskModelAdapter());

  await Future.wait([
    PlantTipsLocalDataSource.openBox(),
    WeatherLocalDataSource.openBox(),
  ]);

  await Firebase.initializeApp();

  setupDependencies();

  AppConfig.lang =
      WidgetsBinding.instance.platformDispatcher.locale.languageCode;
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
            BlocProvider(
              create: (_) => getIt<AuthCubit>(),
            ),
            BlocProvider(
              create: (_) => getIt<OnboardingCubit>(),
            ),
          ],
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light().copyWith(
              scaffoldBackgroundColor:
                  ColorPalette.kPrimaryColor,
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