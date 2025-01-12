import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/constants/hive_types.dart';
import 'package:autro_app/core/extensions/num_extension.dart';
import 'package:autro_app/core/extensions/string_extension.dart';
import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../../../core/extensions/user_role_extension.dart';

part 'user_model.g.dart';

@HiveType(typeId: HiveTypes.user)
class UserModel extends Equatable implements BaseMapable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final UserRole role;
  @HiveField(4)
  final String token;
  @override
  List<Object?> get props => [id, name, email, role, token];

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      role: UserRoleX.fromString((json['role'] as String?).orEmpty),
      id: (json['id'] as int?).toIntOrZero,
      name: (json['name'] as String?).orEmpty,
      email: (json['email'] as String?).orEmpty,
      token: (json['token'] as String?).orEmpty,
    );
  }

  const UserModel({required this.id, required this.name, required this.email, required this.role, required this.token});

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role.str,
    };
  }
}
