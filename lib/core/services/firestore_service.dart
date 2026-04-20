import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService<T> {
  final FirebaseFirestore firestore;

  FirestoreService(this.firestore);

  Stream<List<T>> getData({
    required String collectionName,
    required T Function(Map<String, dynamic> json, String id) fromJson,
  }) {
    return firestore.collection(collectionName).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return fromJson(doc.data(), doc.id);
      }).toList();
    });
  }

  Future<void> add({
    required String collectionName,
    required Map<String, dynamic> data,
  }) {
    return firestore.collection(collectionName).add(data);
  }

  Future<void> update({
    required String collectionName,
    required String docId,
    required Map<String, dynamic> data,
  }) {
    return firestore.collection(collectionName).doc(docId).update(data);
  }

  Future<void> delete({required String collectionName, required String docId}) {
    return firestore.collection(collectionName).doc(docId).delete();
  }

  Future<T?> getById({
    required String collectionName,
    required String docId,
    required T Function(Map<String, dynamic> json, String id) fromJson,
  }) async {
    final doc = await firestore.collection(collectionName).doc(docId).get();
    if (!doc.exists) return null;
    return fromJson(doc.data()!, doc.id);
  }

  Stream<List<T>> queryData({
    required String collectionName,
    required String field,
    required dynamic value,
    required T Function(Map<String, dynamic>, String) fromJson,
  }) {
    return firestore
        .collection(collectionName)
        .where(field, isEqualTo: value)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return fromJson(doc.data(), doc.id);
          }).toList();
        });
  }

  Stream<List<T>> getSubCollection({
    required String path,
    required T Function(Map<String, dynamic>, String) fromJson,
  }) {
    return firestore.collection(path).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return fromJson(doc.data(), doc.id);
      }).toList();
    });
  }
  
}
