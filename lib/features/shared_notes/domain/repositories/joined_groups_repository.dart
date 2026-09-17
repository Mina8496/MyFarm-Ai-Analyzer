import 'package:myfarm/features/shared_notes/domain/entities/joined_group_entity.dart';

abstract class JoinedGroupsRepository {
  Future<List<JoinedGroupEntity>> getAll();
  Future<void> upsert(JoinedGroupEntity group);
  Future<void> remove(String id);
}