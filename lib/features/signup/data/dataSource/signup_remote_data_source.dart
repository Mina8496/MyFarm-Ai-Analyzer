import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:myfarm/features/signup/data/model/user_model.dart';
import 'package:myfarm/features/signup/domain/usecase/signup_params.dart';


abstract class SignupRemoteDataSource {
  Future<UserModel> signup(SignupParams params);
}

class SignupRemoteDataSourceImpl implements SignupRemoteDataSource {
  final fb.FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const SignupRemoteDataSourceImpl(this.auth, this.firestore);

  @override
  Future<UserModel> signup(SignupParams params) async {
    final result = await auth.createUserWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );

    final uid = result.user!.uid;

    await firestore.collection('users').doc(uid).set({
      'name': params.name,
      'phone': params.phone,
      'location': params.location,
      'email': params.email,
    });

    return UserModel(
      id: uid,
      email: params.email,
      name: params.name,
      phone: params.phone,
      location: params.location,
    );
  }
}