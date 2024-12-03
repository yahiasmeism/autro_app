import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/di/di.dart';
import '../../core/router/routes.dart';
import '../../core/widgets/loading_dialog.dart';
import '../authentication/data/repo/auth_repo.dart';
import '../authentication/presentation/bloc/app_auth/app_auth_bloc.dart';

class HomeWrapper extends StatelessWidget {
  const HomeWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppAuthBloc, AppAuthState>(
      listener: listener,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {
          sl<AppAuthBloc>().add(const AppAuthEvent.logout());
        }),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Home Screen'),
              ElevatedButton(
                onPressed: () {
                  sl<AuthRepo>().getUser();
                },
                child: const Text('get current user'),
              )
            ],
          ),
        ),
      ),
    );
  }

  void listener(BuildContext context, AppAuthState state) {
    if (state is SessionExpiredState) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => const Center(
          child: LoadingDialog(message: 'Session Expired. Logging Out'),
        ),
      );
    } else if (state is LoggingOutState) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => const Center(
          child: LoadingDialog(message: 'Logging Out'),
        ),
      );
    }
    if (state is LoggedOutState) {
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }
}
