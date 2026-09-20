import 'package:myfarm/features/group_chat/domain/repositories/group_chat_repository.dart';

class JoinGroupUseCase {
  final GroupChatRepository repo;
  JoinGroupUseCase(this.repo);

  Future<String?> call(String groupId, String userId) async {
    final name = await repo.getGroupName(groupId);
    if (name == null) return null;
    await repo.addMember(groupId: groupId, userId: userId);
    return name;
  }
}