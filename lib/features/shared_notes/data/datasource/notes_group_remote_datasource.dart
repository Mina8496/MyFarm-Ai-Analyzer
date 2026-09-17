import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myfarm/features/shared_notes/data/model/group_note_model.dart';

abstract class NotesGroupRemoteDataSource {
  Future<String> createGroup({
    required String creatorName,
    required String groupName,
  });

  /// يرجّع اسم المجموعة لو موجودة، أو null لو الرقم غير صحيح.
  Future<String?> getGroupName(String groupId);

  Stream<List<GroupNoteModel>> watchNotes(String groupId);
  Future<void> addNote(GroupNoteModel note);
}

class NotesGroupRemoteDataSourceImpl implements NotesGroupRemoteDataSource {
  final FirebaseFirestore _firestore;
  NotesGroupRemoteDataSourceImpl(this._firestore);

  CollectionReference<Map<String, dynamic>> get _groups =>
      _firestore.collection('note_groups');

  @override
  Future<String> createGroup({
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
  Stream<List<GroupNoteModel>> watchNotes(String groupId) {
    return _groups
        .doc(groupId)
        .collection('notes')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs
            .map((d) => GroupNoteModel.fromMap(d.id, groupId, d.data()))
            .toList());
  }

  @override
  Future<void> addNote(GroupNoteModel note) async {
    await _groups.doc(note.groupId).collection('notes').add(note.toMap());
  }
}