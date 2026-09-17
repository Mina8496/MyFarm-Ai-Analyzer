import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myfarm/features/shared_notes/domain/entities/group_note_entity.dart';

class GroupNoteModel extends GroupNoteEntity {
  const GroupNoteModel({
    required super.id,
    required super.groupId,
    required super.content,
    required super.authorName,
    required super.createdAt,
  });

  factory GroupNoteModel.fromMap(String id, String groupId, Map<String, dynamic> map) {
    return GroupNoteModel(
      id: id,
      groupId: groupId,
      content: map['content'] as String? ?? '',
      authorName: map['authorName'] as String? ?? '',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'authorName': authorName,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}