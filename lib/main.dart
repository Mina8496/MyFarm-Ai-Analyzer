import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:myfarm/AppConfig.dart';
import 'package:myfarm/common/constants/color_palette.dart';
import 'package:myfarm/core/localization/app_translations.dart';
import 'package:myfarm/core/routes/app_pages.dart';
import 'package:myfarm/features/plant_analysis/Presentation/Binding/InitialBinding.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  AppConfig.lang =
      WidgetsBinding.instance.platformDispatcher.locale.languageCode;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(255, 56, 147, 59),
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: ColorPalette.kprimaryColor,
            useMaterial3: true,
          ),
          translations: AppTranslations(),
          locale: Get.deviceLocale,
          fallbackLocale: const Locale('en'),
          initialBinding: InitialBinding(),
          initialRoute: '/splashBody',
          getPages: AppPages.pages,
        );
      },
    );
  }
}
