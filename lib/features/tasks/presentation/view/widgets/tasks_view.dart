import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfarm/common/constants/color_palette.dart';
import 'package:myfarm/core/utils/styles.dart';
import 'package:myfarm/features/tasks/data/model/task_model.dart';
import 'package:myfarm/features/tasks/domin/entities/user_role.dart';
import 'package:myfarm/features/tasks/presentation/manger/task_cubit.dart';
import 'package:myfarm/features/tasks/presentation/view/widgets/task_appBar.dart';
import 'package:myfarm/features/tasks/presentation/view/widgets/tasks_body.dart';
import 'package:myfarm/features/tasks/presentation/view/widgets/add_task_bottom_sheet.dart';

class TasksView extends StatefulWidget {
  final UserRole role;
  const TasksView({super.key, required this.role});

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.kPrimaryColor,
      appBar: TasksAppBar(role: widget.role, tabController: _tabController),
      body: TasksBody(
        tabController: _tabController,
        role: widget.role,
        onEditTask: (task) => _openBottomSheet(context, task: task),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openBottomSheet(context),
        backgroundColor: ColorPalette.kLightGreen,
        icon: const Icon(Icons.add),
        label: Text('مهمة جديدة', style: Styles.style14),
      ),
    );
  }

  void _openBottomSheet(BuildContext context, {TaskModel? task}) {
    final cubit = context.read<TaskCubit>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: AddTaskBottomSheet(task: task),
      ),
    );
  }
}
