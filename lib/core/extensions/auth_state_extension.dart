import '../constants/enums.dart';

extension AuthStateX on AuthState {
  static AuthState fromString(String? name) {
    switch (name) {
      case 'authenticated':
        return AuthState.authenticated;
      case 'unauthenticated':
        return AuthState.unauthenticated;
      default:
        return AuthState.unauthenticated;
    }
  }
}
