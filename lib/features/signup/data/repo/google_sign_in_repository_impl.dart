import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myfarm/core/errors/failure.dart';
import 'package:myfarm/features/signup/domain/entities/signup_user.dart';
import 'package:myfarm/features/signup/domain/repo/google_sign_in_repository.dart';

class GoogleSignInRepositoryImpl implements GoogleSignInRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final GoogleSignIn googleSignIn;

  GoogleSignInRepositoryImpl({
    required this.firebaseAuth,
    required this.firestore,
    required this.googleSignIn,
  });

  @override
  Future<Either<Failure, SignupUser>> signInWithGoogle() async {
    try {
      await googleSignIn.initialize();
      final googleUser = await googleSignIn.authenticate();
      final googleAuth = googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCredential = await firebaseAuth.signInWithCredential(
        credential,
      );
      final user = userCredential.user;
      if (user == null) {
        return Left(UnknownFailure('Google sign-in failed'));
      }

      await firestore.collection('users').doc(user.uid).set({
        'id': user.uid,
        'email': user.email ?? '',
        'name': user.displayName ?? 'Google User',
        'phone': user.phoneNumber ?? '',
        'createdAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      return Right(
        SignupUser(
          id: user.uid,
          email: user.email ?? '',
          name: user.displayName ?? 'Google User',
          phone: user.phoneNumber ?? '',
        ),
      );
    }     catch (e) {
      return  Left(UnknownFailure('حدث خطأ أثناء تسجيل الدخول بجوجل'));
    }
  }
}
