import 'package:hive/hive.dart';
import 'package:myfarm/features/tasks/domin/entities/task_entity.dart';

part 'task_model.g.dart';

@HiveType(typeId: 2)
class TaskModel with HiveObjectMixin {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final bool isCompleted;
  @HiveField(4)
  final DateTime createdAt;
  @HiveField(5)
  final String createdByRole;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.createdAt,
    required this.createdByRole,
  });

  factory TaskModel.fromEntity(TaskEntity e) => TaskModel(
    id: e.id,
    title: e.title,
    description: e.description,
    isCompleted: e.isCompleted,
    createdAt: e.createdAt,
    createdByRole: e.createdByRole,
  );

  TaskEntity toEntity() => TaskEntity(
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
