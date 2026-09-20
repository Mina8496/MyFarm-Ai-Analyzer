import 'package:myfarm/features/shared_notes/domain/repositories/notes_group_repository.dart';

class JoinGroupUseCase {
  final NotesGroupRepo repo;
  JoinGroupUseCase(this.repo);

  Future<String?> call(String groupId, String userId) async {
    final name = await repo.getGroupName(groupId);
    if (name == null) return null;
    await repo.addMember(groupId: groupId, userId: userId);
    return name;
  }
}
