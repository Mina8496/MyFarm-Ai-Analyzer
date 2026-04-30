import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:myfarm/features/login/data/models/user_model.dart';

abstract class LoginRemoteDataSource {
  Future<UserModel> login(String email, String password);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final fb.FirebaseAuth auth;
  const LoginRemoteDataSourceImpl(this.auth);

  @override
  Future<UserModel> login(String email, String password) async {
    final result = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return UserModel(
      id: result.user!.uid,
      email: result.user!.email!,
    );
  }
}
