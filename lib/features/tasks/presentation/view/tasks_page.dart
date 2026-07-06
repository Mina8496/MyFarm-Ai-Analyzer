import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfarm/core/function/injection_container.dart';
import 'package:myfarm/core/storage/app_storage.dart';
import 'package:myfarm/core/widgets/auth_required_dialog.dart';
import 'package:myfarm/features/tasks/domin/entities/user_role.dart';
import 'package:myfarm/features/tasks/domin/usecases/add_task_usecase.dart';
import 'package:myfarm/features/tasks/domin/usecases/delete_task_usecase.dart';
import 'package:myfarm/features/tasks/domin/usecases/edit_task_usecase.dart';
import 'package:myfarm/features/tasks/domin/usecases/get_tasks_usecase.dart';
import 'package:myfarm/features/tasks/domin/usecases/toggle_complete_usecase.dart';
import 'package:myfarm/features/tasks/presentation/manger/task_cubit.dart';
import 'package:myfarm/features/tasks/presentation/view/widgets/tasks_view.dart';

UserRole userRoleFromFirebaseValue(String? value) {
  switch ((value ?? '').trim().toLowerCase()) {
    case 'engineer':
      return UserRole.engineer;
    case 'supervisor':
      return UserRole.supervisor;
    case 'owner':
      return UserRole.owner;
    case 'farmer':
    default:
      return UserRole.farmer;
  }
}

class TasksPage extends StatelessWidget {
  final UserRole? role;
  const TasksPage({super.key, this.role});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserRole>(
      future: _resolveRole(),
      builder: (context, snapshot) {
        final resolvedRole = snapshot.data ?? role ?? UserRole.farmer;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (fb.FirebaseAuth.instance.currentUser == null) {
            _showLoginDialog(context);
          }
        });

        return BlocProvider(
          create: (_) => TaskCubit(
            currentRole: resolvedRole,
            getTasksUseCase: getIt<GetTasksUseCase>(),
            addTaskUseCase: getIt<AddTaskUseCase>(),
            deleteTaskUseCase: getIt<DeleteTaskUsecase>(),
            editTaskUseCase: getIt<EditTaskUseCase>(),
            toggleCompleteUseCase: getIt<ToggleCompleteUseCase>(),
          )..loadTasks(),
          child: TasksView(role: resolvedRole),
        );
      },
    );
  }

  void _showLoginDialog(BuildContext context) {
    AuthRequiredDialog.show(
      context,
      message: 'يجب تسجيل الدخول أولاً قبل استخدام صفحة المهام.',
    );
  }

  Future<UserRole> _resolveRole() async {
    if (role != null) {
      await AppStorage.saveUserType(role!.name);
      return role!;
    }

    final savedRoleCode = await AppStorage.getUserType();
    if (savedRoleCode != null && savedRoleCode.isNotEmpty) {
      final savedRole = userRoleFromFirebaseValue(savedRoleCode);
      await AppStorage.saveUserType(savedRole.name);
      return savedRole;
    }

    final user = fb.FirebaseAuth.instance.currentUser;
    final fallbackRole = role ?? UserRole.farmer;

    if (user == null) {
      await _persistUserType(fallbackRole);
      return fallbackRole;
    }

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    final value = doc.data()?['userType'] as String?;
    final resolvedRole = userRoleFromFirebaseValue(value);
    await _persistUserType(resolvedRole);
    return resolvedRole;
  }

  Future<void> _persistUserType(UserRole role) async {
    final user = fb.FirebaseAuth.instance.currentUser;
    if (user == null) return;

    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'userType': role.name,
    }, SetOptions(merge: true));
  }
}
