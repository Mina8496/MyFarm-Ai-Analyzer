import 'package:myfarm/features/shared_notes/domain/repositories/notes_group_repository.dart';

class JoinGroupUseCase {
  final NotesGroupRepo repo;
  JoinGroupUseCase(this.repo);

  /// يرجّع اسم المجموعة لو الرقم صحيح، أو null لو مش موجودة.
  Future<String?> call(String groupId) => repo.getGroupName(groupId);
}