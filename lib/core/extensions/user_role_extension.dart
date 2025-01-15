import 'package:autro_app/core/constants/enums.dart';

extension UserRoleX on UserRole {
  String get str {
    switch (this) {
      case UserRole.admin:
        return 'Admin';
      case UserRole.user:
        return 'User';
      case UserRole.viewer:
        return 'Viewer';
      default:
        return 'Unknown';
    }
  }

  bool get isAdmin => this == UserRole.admin;

  bool get isUser => this == UserRole.user;

  bool get isViewer => this == UserRole.viewer;

  static UserRole fromString(String? name) {
    switch (name?.toLowerCase()) {
      case 'admin':
        return UserRole.admin;
      case 'user':
        return UserRole.user;
      case 'viewer':
        return UserRole.viewer;
      default:
        return UserRole.user;
    }
  }
}
