
import 'package:myfarm/features/login/domain/entity/user_entity.dart';

class UserModel {
  final String id;
  final String email;

  const UserModel({
    required this.id,
    required this.email,
  });

  UserEntity toEntity() => UserEntity(
        id: id,
        email: email,
      );
}