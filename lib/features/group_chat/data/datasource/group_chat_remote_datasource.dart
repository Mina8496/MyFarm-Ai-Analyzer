import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myfarm/features/group_chat/data/model/group_note_model.dart';
import 'package:myfarm/features/group_chat/domain/entities/joined_group_entity.dart';

abstract class GroupChatRemoteDataSource {
  Future<String> createGroup({
    required String creatorId,
    required String creatorName,
    required String groupName,
  });

  Future<String?> getGroupName(String groupId);

  Future<void> addMember({required String groupId, required String userId});

  Future<List<JoinedGroupEntity>> getMyGroups(String userId);

  Stream<List<GroupNoteModel>> watchNotes(String groupId);
  Future<void> addNote(GroupNoteModel note);
}

class GroupChatRemoteDataSourceImpl implements GroupChatRemoteDataSource {
  final FirebaseFirestore _firestore;
  GroupChatRemoteDataSourceImpl(this._firestore);

  CollectionReference<Map<String, dynamic>> get _groups =>
      _firestore.collection('note_groups');

  @override
  Future<String> createGroup({
    required String creatorId,
    required String creatorName,
    required String groupName,
  }) async {
    for (var attempt = 0; attempt < 5; attempt++) {
      final id = _generateCode();
      final doc = _groups.doc(id);
      final snapshot = await doc.get();
      if (!snapshot.exists) {
        await doc.set({
          'name': groupName,
          'createdAt': FieldValue.serverTimestamp(),
          'createdBy': creatorName,
          'memberIds': [creatorId],
        });
        return id;
      }
    }
    throw Exception('تعذر إنشاء المجموعة، حاول مرة أخرى');
  }

  String _generateCode() {
    final rand = Random();
    return List.generate(6, (_) => rand.nextInt(10)).join();
  }

  @override
  Future<String?> getGroupName(String groupId) async {
    final doc = await _groups.doc(groupId).get();
    if (!doc.exists) return null;
    final name = doc.data()?['name'] as String?;
    return (name != null && name.trim().isNotEmpty) ? name : 'مجموعة بدون اسم';
  }

  @override
  Future<void> addMember({
    required String groupId,
    required String userId,
  }) async {
    await _groups.doc(groupId).update({
      'memberIds': FieldValue.arrayUnion([userId]),
    });
  }

  @override
  Future<List<JoinedGroupEntity>> getMyGroups(String userId) async {
    if (userId.isEmpty) return [];
    final snap = await _groups.where('memberIds', arrayContains: userId).get();
    return snap.docs.map((d) {
      final name = d.data()['name'] as String?;
      return JoinedGroupEntity(
        id: d.id,
        name: (name != null && name.trim().isNotEmpty)
            ? name
            : 'مجموعة بدون اسم',
      );
    }).toList();
  }

  @override
  Stream<List<GroupNoteModel>> watchNotes(String groupId) {
    return _groups
        .doc(groupId)
        .collection('notes')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snap) => snap.docs
              .map((d) => GroupNoteModel.fromMap(d.id, groupId, d.data()))
              .toList(),
        );
  }

  @override
  Future<void> addNote(GroupNoteModel note) async {
    await _groups.doc(note.groupId).collection('notes').add(note.toMap());
  }
}