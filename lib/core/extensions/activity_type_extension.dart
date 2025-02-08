import 'package:autro_app/core/constants/enums.dart';
import 'package:flutter/material.dart';

extension ActivityTypeX on ActivityType {
  static ActivityType fromString(String value) {
    switch (value) {
      case 'create':
        return ActivityType.create;
      case 'update':
        return ActivityType.update;
      case 'delete':
        return ActivityType.delete;
      default:
        return ActivityType.unknown;
    }
  }

  String get str {
    switch (this) {
      case ActivityType.create:
        return 'Create';
      case ActivityType.update:
        return 'Update';
      case ActivityType.delete:
        return 'Delete';
      default:
        return '';
    }
  }

  Color get color {
    switch (this) {
      case ActivityType.create:
        return Colors.green;
      case ActivityType.update:
        return Colors.orange;
      case ActivityType.delete:
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}
