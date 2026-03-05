import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:myfarm/app_config.dart';
import 'package:myfarm/common/constants/color_palette.dart';
import 'package:myfarm/core/localization/app_translations.dart';
import 'package:myfarm/core/utils/routes/app_pages.dart';
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
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: AppColors.kPrimaryColor,
            useMaterial3: true,
          ),
          translations: AppTranslations(),
          locale: Get.deviceLocale,
          initialBinding: InitialBinding(),
          initialRoute: '/splash',
          getPages: AppPages.pages,
        );
      },
    );
  }
}
