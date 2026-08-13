import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'toolbox_page_body.dart';
import '../manager/toolboxPage_cubit.dart';

class ToolboxPage extends StatelessWidget {
  const ToolboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ToolboxPageCubit()..init(),
      child: const Scaffold(body: ToolboxPageBody()),
    );
  }
}
