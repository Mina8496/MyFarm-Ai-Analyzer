class GroupNoteEntity {
  final String id;
  final String groupId;
  final String content;
  final String authorName;
  final DateTime createdAt;

  const GroupNoteEntity({
    required this.id,
    required this.groupId,
    required this.content,
    required this.authorName,
    required this.createdAt,
  });
}