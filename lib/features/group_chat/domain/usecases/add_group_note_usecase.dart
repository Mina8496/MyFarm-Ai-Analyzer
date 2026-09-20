import 'package:myfarm/features/group_chat/domain/repositories/group_chat_repository.dart';

class AddGroupNoteUseCase {
  final GroupChatRepository repo;
  AddGroupNoteUseCase(this.repo);

  Future<void> call({
    required String groupId,
    required String authorId,
    required String content,
    required String authorName,
  }) =>
      repo.addNote(
        groupId: groupId,
        authorId: authorId,
        content: content,
        authorName: authorName,
      );
}