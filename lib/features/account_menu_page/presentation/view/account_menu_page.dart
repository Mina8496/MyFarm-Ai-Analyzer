import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'account_menu_page_body.dart';
import '../manager/account_menu_cubit.dart';

class AccountMenuPage extends StatelessWidget {
  const AccountMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AccountMenuCubit()..init(),
      child: const Scaffold(body: AccountMenuPageBody()),
    );
  }
}
