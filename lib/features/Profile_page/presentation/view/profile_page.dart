import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_page_body.dart';
import '../manager/profile_page_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfilePageCubit()..init(),
      child: const Scaffold(body: ProfilePageBody()),
    );
  }
}
