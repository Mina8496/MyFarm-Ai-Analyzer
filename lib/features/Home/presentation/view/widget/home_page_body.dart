import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:myfarm/core/widgets/app_auth_header.dart';
import 'package:myfarm/core/widgets/app_header_rich_text.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppAuthHeader(
          child: AppHeaderRichText(
            title_1: "Your_location".tr,
            title_2: "title_2",
          ),
        ),
      ],
    );
  }
}
