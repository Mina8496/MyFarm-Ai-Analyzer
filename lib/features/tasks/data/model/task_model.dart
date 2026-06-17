import 'package:hive/hive.dart';
import 'package:myfarm/features/tasks/domin/entities/task_entity.dart';

part 'task_model.g.dart';

@HiveType(typeId: 2)
class TaskModel extends TaskEntity with HiveObjectMixin {
  @HiveField(0)
  @override
  final String id;

  @HiveField(1)
  @override
  final String title;

  @HiveField(2)
  @override
  final String description;

  @HiveField(3)
  @override
  final bool isCompleted;

  @HiveField(4)
  @override
  final DateTime createdAt;

  @HiveField(5)
  @override
  final String createdByRole;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.createdAt,
    required this.createdByRole,
  }) : super(
         id: id,
         title: title,
         description: description,
         isCompleted: isCompleted,
         createdAt: createdAt,
         createdByRole: createdByRole,
       );

  TaskModel copyWith({String? title, String? description, bool? isCompleted}) {
    return TaskModel(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt,
      createdByRole: createdByRole,
    );
  }
}
