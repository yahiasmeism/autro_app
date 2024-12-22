import 'package:flutter/cupertino.dart';

class NavUtil {
  static Future<T?> to<T extends Object?>(BuildContext context, String? routeName, [Object? args]) {
    if (routeName == null) return Future.value();
    return Navigator.of(context).pushNamed<T>(routeName, arguments: args);
  }

  static Future<T?> toR<T extends Object?, TO extends Object?>(BuildContext context, String? routeName,
      {TO? result, Object? args}) {
    if (routeName == null) return Future.value();
    return Navigator.of(context).pushReplacementNamed<T, TO>(routeName, result: result, arguments: args);
  }

  static Future<T?> push<T extends Object?>(BuildContext context, Widget widget, {bool fullscreenDialog = false}) {
    return Navigator.of(context).push<T>(
      CupertinoPageRoute(builder: (builder) => widget, fullscreenDialog: fullscreenDialog),
    );
  }

  static Future<T?> pushR<T extends Object?, TO extends Object?>(BuildContext context, Widget widget,
      {bool fullscreenDialog = false}) {
    return Navigator.of(context).pushReplacement<T, TO>(
      CupertinoPageRoute(builder: (builder) => widget, fullscreenDialog: fullscreenDialog),
    );
  }

  static void pop(BuildContext context, [dynamic result]) {
    return Navigator.of(context).pop(result);
  }

  static void popToRoot(BuildContext context, [dynamic result]) {
    return Navigator.of(context).popUntil((route) => route.isFirst);
  }

  static void checkAndPop(BuildContext context, [dynamic result]) {
    if (canPop(context)) {
      return Navigator.of(context).pop(result);
    }
  }

  static bool canPop(BuildContext context) {
    return Navigator.of(context).canPop();
  }
}
