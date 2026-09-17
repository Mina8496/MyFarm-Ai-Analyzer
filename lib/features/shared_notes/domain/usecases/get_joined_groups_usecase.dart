import 'package:myfarm/features/shared_notes/domain/entities/joined_group_entity.dart';
import 'package:myfarm/features/shared_notes/domain/repositories/joined_groups_repository.dart';

class GetJoinedGroupsUseCase {
  final JoinedGroupsRepository repo;
  GetJoinedGroupsUseCase(this.repo);
  Future<List<JoinedGroupEntity>> call() => repo.getAll();
}

