import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CurrentUserService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>?> getCurrentUserData() async {
    final uid = auth.currentUser?.uid;

    if (uid == null) return null;

    final doc = await firestore.collection('users').doc(uid).get();

    if (!doc.exists) return null;

    return doc.data();
  }
}