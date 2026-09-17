import 'package:myfarm/features/shared_notes/domain/entities/joined_group_entity.dart';
import 'package:myfarm/features/shared_notes/domain/repositories/joined_groups_repository.dart';

class SaveJoinedGroupUseCase {
  final JoinedGroupsRepository repo;
  SaveJoinedGroupUseCase(this.repo);
  Future<void> call(JoinedGroupEntity group) => repo.upsert(group);
}
