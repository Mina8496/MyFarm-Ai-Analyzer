  import 'package:myfarm/features/shared_notes/domain/repositories/notes_group_repository.dart';

  class CreateGroupUseCase {
    final NotesGroupRepo repo;
    CreateGroupUseCase(this.repo);

    Future<String> call({
      required String creatorName,
      required String groupName,
    }) =>
        repo.createGroup(creatorName: creatorName, groupName: groupName);
  }