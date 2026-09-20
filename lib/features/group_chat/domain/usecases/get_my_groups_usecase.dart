import 'package:myfarm/features/group_chat/domain/entities/joined_group_entity.dart';
import 'package:myfarm/features/group_chat/domain/repositories/group_chat_repository.dart';

class GetMyGroupsUseCase {
  final GroupChatRepository repo;
  GetMyGroupsUseCase(this.repo);

  Future<List<JoinedGroupEntity>> call(String userId) => repo.getMyGroups(userId);
}