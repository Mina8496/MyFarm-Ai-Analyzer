import 'package:myfarm/features/shared_notes/domain/entities/joined_group_entity.dart';
import 'package:myfarm/features/shared_notes/domain/repositories/notes_group_repository.dart';

class GetMyGroupsUseCase {
  final NotesGroupRepo repo;
  GetMyGroupsUseCase(this.repo);

  Future<List<JoinedGroupEntity>> call(String userId) => repo.getMyGroups(userId);
}