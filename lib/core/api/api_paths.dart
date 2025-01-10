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
}
