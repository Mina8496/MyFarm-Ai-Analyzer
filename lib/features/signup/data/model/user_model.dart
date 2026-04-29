
import 'package:myfarm/features/signup/domain/entities/user.dart';

class UserModel {
  final String id;
  final String email;
  final String name;
  final String phone;
  final String location;

  const UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.location,
  });

  User toEntity() => User(
    id: id,
    email: email,
    name: name,
    phone: phone,
    location: location,
  );
}