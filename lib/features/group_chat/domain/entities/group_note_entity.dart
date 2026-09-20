class GroupNoteEntity {
  final String id;
  final String groupId;
  final String content;
  final String authorId;
  final String authorName;
  final DateTime createdAt;

  const GroupNoteEntity({
    required this.id,
    required this.groupId,
    required this.content,
    required this.authorId,
    required this.authorName,
    required this.createdAt,
  });
}