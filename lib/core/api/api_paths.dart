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

  // proformas
  static const String proformas = 'proformas';
  static String proformaById(int id) => 'proformas/$id';

  // invoices
  static const String invoices = 'invoices';
  static String invoiceById(int id) => 'invoices/$id';

  // bills
  static const String bills = 'bills';
  static String billById(int id) => 'bills/$id';
}
