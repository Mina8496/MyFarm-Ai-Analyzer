import 'package:myfarm/features/shared_notes/data/local/joined_groups_storage.dart';
import 'package:myfarm/features/shared_notes/domain/entities/joined_group_entity.dart';
import 'package:myfarm/features/shared_notes/domain/repositories/joined_groups_repository.dart';

class JoinedGroupsRepositoryImpl implements JoinedGroupsRepository {
  final JoinedGroupsLocalDataSource localDataSource;
  JoinedGroupsRepositoryImpl(this.localDataSource);

  @override
  Future<List<JoinedGroupEntity>> getAll() => localDataSource.getAll();

  @override
  Future<void> upsert(JoinedGroupEntity group) =>
      localDataSource.upsert(JoinedGroupModel(id: group.id, name: group.name));

  @override
  Future<void> remove(String id) => localDataSource.remove(id);
}