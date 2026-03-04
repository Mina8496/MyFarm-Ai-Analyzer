import 'package:flutter/material.dart';
import 'package:myfarm/features/Home/presentation/view/widget/home_page_body.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(context) {
    return const Scaffold(
      body: HomePageBody(),
    );
  }
}