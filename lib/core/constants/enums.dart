import 'package:autro_app/core/constants/hive_types.dart';
import 'package:hive/hive.dart';
part 'enums.g.dart';

enum AuthState {
  authenticated,
  unauthenticated,
}

enum HiveBoxType { user }

@HiveType(typeId: HiveTypes.userRoles)
enum UserRole {
  @HiveField(0)
  admin,
  @HiveField(1)
  user,
  @HiveField(2)
  viewer,
}

enum MenuItemType {
  dashboard,
  invoices,
  deals,
  proformas,
  customers,
  accounting,
  shipping,
  settings,
  bills,
  suppliers,
  messages,
}

enum ConditionOperator {
  equals,
  greaterThan,
  lessThan,
  notEquals,
  contains,
  startsWith,
  endsWith,
  withIn,
  notIn,
  greaterThanOrEqual,
  lessThanOrEqual
}

enum PrimaryContectType {
  email,
  phone,
  unknown,
}

enum FormType {
  create,
  edit,
}
