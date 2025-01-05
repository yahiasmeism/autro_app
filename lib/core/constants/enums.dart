enum AuthState {
  authenticated,
  unauthenticated,
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
