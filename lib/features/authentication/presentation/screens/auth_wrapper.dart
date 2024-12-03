import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/home_wrapper.dart';
import '../bloc/app_auth/app_auth_bloc.dart';
import 'login_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppAuthBloc, AppAuthState>(
      buildWhen: (previous, current) {
        return current is AuthenticatedState || current is UnAuthenticatedState;
      },
      builder: (context, state) {
        return state.maybeMap(
          authenticated: (value) => const HomeWrapper(),
          unAuthenticated: (value) => const LoginScreen(),
          loggedOut: (value) => const LoginScreen(),
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
