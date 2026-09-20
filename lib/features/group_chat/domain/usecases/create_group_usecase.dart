import 'package:myfarm/features/group_chat/domain/repositories/group_chat_repository.dart';

class CreateGroupUseCase {
  final GroupChatRepository repo;
  CreateGroupUseCase(this.repo);

  Future<String> call({
    required String creatorId,
    required String creatorName,
    required String groupName,
  }) =>
      repo.createGroup(
        creatorId: creatorId,
        creatorName: creatorName,
        groupName: groupName,
      );
}