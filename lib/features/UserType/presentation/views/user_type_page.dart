import 'package:flutter/material.dart';
import 'package:myfarm/features/UserType/presentation/views/widgets/user_type_page_Body.dart';

class UserTypeSelectionPage extends StatefulWidget {
  const UserTypeSelectionPage({super.key});

  @override
  State<UserTypeSelectionPage> createState() => _UserTypeSelectionPageState();
}

class _UserTypeSelectionPageState extends State<UserTypeSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: UserTypeSelectionPageBody());
  }
}
