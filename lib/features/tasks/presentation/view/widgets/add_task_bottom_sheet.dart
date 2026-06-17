import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfarm/common/constants/color_palette.dart';
import 'package:myfarm/core/utils/styles.dart';
import 'package:myfarm/features/tasks/data/model/task_model.dart';
import 'package:myfarm/features/tasks/presentation/manger/task_cubit.dart';
import 'package:myfarm/features/tasks/presentation/view/widgets/task_text_field.dart';

class AddTaskBottomSheet extends StatefulWidget {
  final TaskModel? task;
  const AddTaskBottomSheet({super.key, this.task});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  late final TextEditingController _titleController;
  late final TextEditingController _descController;
  late final bool _isEdit;

  @override
  void initState() {
    super.initState();
    _isEdit = widget.task != null;
    _titleController = TextEditingController(text: widget.task?.title);
    _descController = TextEditingController(text: widget.task?.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TaskCubit>();

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 24,
        right: 24,
        top: 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                _isEdit ? 'تعديل المهمة' : 'إضافة مهمة جديدة',
                style: Styles.styleBold18,
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(
                  Icons.close,
                  color: ColorPalette.kPrimaryColor,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TaskTextField(controller: _titleController, hint: 'عنوان المهمة'),
          const SizedBox(height: 12),
          TaskTextField(
            controller: _descController,
            hint: 'الوصف (اختياري)',
            maxLines: 3,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorPalette.kPrimaryColor,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _submit(cubit),
              child: Text(
                _isEdit ? 'حفظ التعديل' : 'إضافة المهمة',
                style: Styles.style16,
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  VoidCallback _submit(TaskCubit cubit) => () {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;

    if (_isEdit) {
      cubit.editTask(
        taskId: widget.task!.id,
        newTitle: title,
        newDescription: _descController.text.trim(),
      );
    } else {
      cubit.addTask(title: title, description: _descController.text.trim());
    }
    Navigator.pop(context);
  };
}
