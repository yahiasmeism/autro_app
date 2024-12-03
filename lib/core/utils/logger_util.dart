import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class LoggerUtils {
  LoggerUtils._();
  static final Logger _logger = Logger();

  static print(String message) {
    if (kDebugMode) {
      _logger.log(Level.info, message);
    }
  }

  static e(String message) {
    _logger.log(Level.error, message);
  }
}
