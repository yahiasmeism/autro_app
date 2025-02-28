import 'package:autro_app/core/constants/hive_types.dart';
import 'package:hive/hive.dart';
part 'enums.g.dart';

enum AuthState {
  authenticated,
  unauthenticated,
}

enum ClientType { customer, supplier, unknown }

enum PdfAction { view, export }

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
  shipping,
  settings,
  bills,
  suppliers,
  packingLists,
  blInstructions,
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

enum PackingType { bales, loose, bulks, rolls, packing, lots, unknown }

enum ModuleType {
  bankAccount,
  bill,
  customer,
  customerInvoice,
  customerProforma,
  deal,
  packingList,
  shippingInvoice,
  supplier,
  supplierInvoice,
  supplierProforma,
  user,
  company,
  unknown,
}

enum ActivityType {
  create,
  update,
  delete,
  unknown,
}
