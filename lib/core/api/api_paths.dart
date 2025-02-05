abstract class ApiPaths {
  static const String baseUrl = 'http://127.0.0.1:8000/api/';
  static const String login = 'login';
  static const String register = 'register';
  static const String logout = 'logout';
  static const String currentUser = 'user';

  //customers

  static const String customers = 'customers';
  static String customerById(int id) => 'customers/$id';

  //suppliers

  static const String suppliers = 'suppliers';
  static String supplierById(int id) => 'suppliers/$id';

  // company
  static const String company = 'company';

  // bank accounts
  static const String bankAccounts = 'bank-accounts';
  static String bankAccountById(int id) => 'bank-accounts/$id';

  // users
  static const String users = 'users';
  static String userById(int id) => 'users/$id';

  // invoice settings
  static const String invoiceSettings = 'invoice-settings';

  // customers proformas
  static const String customerProformas = 'customers-proformas';
  static String customerProformaById(int id) => 'customers-proformas/$id';
  // supplier proformas
  static const String supplierProformas = 'suppliers-proformas';
  static String supplierProformasById(int id) => 'suppliers-proformas/$id';

  // invoices
  static const String customerInvoices = 'customers-invoices';
  static String customerInvoiceById(int id) => 'customers-invoices/$id';
  // invoices
  static const String supplierInvoices = 'suppliers-invoices';
  static String supplierInvoicesById(int id) => 'suppliers-invoices/$id';

  // bills
  static const String bills = 'bills';
  static const String billsSummary = 'bills/summary';
  static String billById(int id) => 'bills/$id';

  // shipping invoices
  static const String shippingInvoices = 'shipping-invoices';
  static String shippingInvoiceById(int id) => 'shipping-invoices/$id';

  // deals
  static const String deals = 'deals';
  static String dealById(int id) => 'deals/$id';

  // deal bills
  static String dealBillById(int billId) => 'deals/bills/$billId';
  static String dealBills(int dealId) => 'deals/$dealId/bills';
}
