import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/settings/domin/use_cases/add_new_user_use_case.dart';

class AddNewUserRequest extends AddNewUserUseCaseParams implements RequestMapable {
  const AddNewUserRequest({
    required super.email,
    required super.name,
    required super.password,
    required super.role,
  });

  factory AddNewUserRequest.fromParams(AddNewUserUseCaseParams params) {
    return AddNewUserRequest(
      email: params.email,
      name: params.name,
      password: params.password,
      role: params.role,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'role': role,
    };
  }
}
