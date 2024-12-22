import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/screens/home_wrapper.dart';
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
        if (state is AuthenticatedState) {
          return const HomeWrapper();
        } else if (state is UnAuthenticatedState) {
          return const LoginScreen();
        } else if (state is LoggedOutState) {
          return const LoginScreen();
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
