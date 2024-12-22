import 'dart:io';

import 'package:autro_app/features/authentication/presentation/screens/auth_wrapper.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'core/constants/app_colors.dart';
import 'core/di/di.dart';
import 'features/authentication/presentation/bloc/app_auth/app_auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection(Environment.prod);

  runApp(const MyApp());
  _initializeDesktopWindow();
}

_initializeDesktopWindow() {
  if (Platform.isWindows) {
    doWhenWindowReady(() {
      const initialWidth = 1200.0;
      const aspectRatio = 16 / 9;
      const initialHeight = initialWidth / aspectRatio;

      appWindow
        ..minSize = const Size(initialWidth, initialWidth / aspectRatio)
        ..size = const Size(initialWidth, initialHeight)
        ..alignment = Alignment.center
        ..show();
    });
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AppAuthBloc>()..add(CheckAuthenticationAppEvent()),
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primaryColor,
            primary: AppColors.primaryColor,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const AuthWrapper(),
      ),
    );
  }
}
