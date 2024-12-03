import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../features/authentication/presentation/screens/auth_wrapper.dart';
import '../../features/authentication/presentation/screens/login_screen.dart';
import '../../features/authentication/presentation/screens/register_screen.dart';
import '../../features/home/home_wrapper.dart';
import 'routes.dart';

class AppRouter {
  static Map<String, WidgetBuilder> registerRoutes() {
    return <String, WidgetBuilder>{
      AppRoutes.initial: (context) => const AuthWrapper(),
      AppRoutes.home: (context) => const HomeWrapper(),
      AppRoutes.login: (context) => const LoginScreen(),
      AppRoutes.register: (context) => const RegisterScreen(),
    };
  }

  static Route registerRoutesWithParameters(RouteSettings settings) {
    switch (settings.name) {
      // case AppRoutes.consignmentDetailsScreen:
      // return adaptivePageRoute(
      //   builder: (context) {
      //     final consignment = settings.arguments as ConsignmentEntity;
      //     return ConsignmentDetailsScreen(consignment: consignment);
      //   },
      // );
    }
    return adaptivePageRoute(
      builder: (context) {
        return const SizedBox();
      },
    );
  }

  static PageRoute adaptivePageRoute<T>({
    required Widget Function(BuildContext) builder,
    String? title,
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
    bool allowSnapshotting = true,
  }) {
    if (Platform.isIOS) {
      return CupertinoPageRoute<T>(
        builder: builder,
        title: title,
        settings: settings,
        maintainState: maintainState,
        fullscreenDialog: fullscreenDialog,
        allowSnapshotting: allowSnapshotting,
      );
    }
    return MaterialPageRoute<T>(
      builder: builder,
      settings: settings,
      maintainState: maintainState,
      fullscreenDialog: fullscreenDialog,
      allowSnapshotting: allowSnapshotting,
    );
  }
}
