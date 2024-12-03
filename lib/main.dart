import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'core/di/di.dart';
import 'core/router/router.dart';
import 'features/authentication/presentation/bloc/app_auth/app_auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection(Environment.prod);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AppAuthBloc>()..add(const AppAuthEvent.checkAuthentication()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
          useMaterial3: true,
        ),
        routes: AppRouter.registerRoutes(),
        onGenerateRoute: AppRouter.registerRoutesWithParameters,
      ),
    );
  }
}
