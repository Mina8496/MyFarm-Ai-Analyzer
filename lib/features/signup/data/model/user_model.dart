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

  factory UserModel.fromJson(
    Map<String, dynamic> json,
    String id,
  ) {
    return UserModel(
      id: id,
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
    };
  }

  SignupUser toEntity() {
    return SignupUser(
      id: id,
      email: email,
      name: name,
      phone: phone,
    );
  }

  factory UserModel.fromEntity(SignupUser user) {
    return UserModel(
      id: user.id,
      email: user.email,
      name: user.name,
      phone: user.phone,
    );
  }
}