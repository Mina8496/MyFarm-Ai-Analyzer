import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfarm/common/constants/color_palette.dart';
import 'package:myfarm/core/utils/styles.dart';
import 'package:myfarm/features/tasks/domin/entities/task_entity.dart';
import 'package:myfarm/features/tasks/domin/entities/user_role.dart';
import 'package:myfarm/features/tasks/presentation/manger/task_cubit.dart';
import 'package:myfarm/features/tasks/presentation/view/widgets/task_app_bar.dart';
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
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    // نعمل rebuild بس لما التاب يتغير فعليًا (مش أثناء السحب المتوسط)
    if (!_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
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
      floatingActionButton: _tabController.index == 2
          ? null
          : FloatingActionButton.extended(
              heroTag: 'tasks_view_fab',
              onPressed: () => _openBottomSheet(context),
              backgroundColor: ColorPalette.kLightGreen,
              icon: const Icon(Icons.add),
              label: Text('مهمة جديدة', style: Styles.style14),
            ),
    );
  }

  void _openBottomSheet(BuildContext context, {TaskEntity? task}) {
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
