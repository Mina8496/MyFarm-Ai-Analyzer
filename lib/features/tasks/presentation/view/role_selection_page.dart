import 'package:flutter/material.dart';
import 'package:myfarm/features/tasks/presentation/view/role_selection_page_body.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: RoleSelectionBody(),
        ),
      ),
    );
  }
}
