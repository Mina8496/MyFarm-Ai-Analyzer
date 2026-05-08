import 'package:myfarm/features/signup/domain/entities/signup_user.dart';

class UserModel {
  final String id;
  final String email;
  final String name;
  final String phone;

  const UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
  });

  SignupUser toEntity() => SignupUser(
    id: id,
    email: email,
    name: name,
    phone: phone,
  );
}
