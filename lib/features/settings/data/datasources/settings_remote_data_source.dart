import 'package:autro_app/core/api/api_client.dart';
import 'package:autro_app/core/api/api_paths.dart';
import 'package:autro_app/core/api/api_request.dart';
import 'package:autro_app/core/common/data/responses/pagination_list_response.dart';
import 'package:autro_app/core/errors/error_handler.dart';
import 'package:autro_app/core/errors/exceptions.dart';
import 'package:autro_app/features/authentication/data/models/user_model.dart';
import 'package:autro_app/features/settings/data/models/company_model.dart';
import 'package:autro_app/features/settings/data/models/invoice_settings_model.dart';
import 'package:autro_app/features/settings/data/models/requests/add_new_user_request.dart';
import 'package:autro_app/features/settings/data/models/requests/change_company_info_request.dart';
import 'package:autro_app/features/settings/domin/entities/bank_account_entity.dart';
import 'package:injectable/injectable.dart';

import '../models/bank_account_model.dart';
import '../models/requests/add_bank_account_request.dart';
import '../models/requests/update_bank_account_request.dart';

abstract class SettingsRemoteDataSource {
  Future<CompanyModel> changeCompanyInfo(ChangeCompanyInfoRequest body);
  Future<CompanyModel> getCompany();
  Future<BankAccountModel> addBankAccount(AddBankAccountRequest body);
  Future<List<BankAccountModel>> getBankAccountsList();
  Future<void> deleteBankAccount(int bankAccountId);
  Future<List<UserModel>> getUsersList();
  Future<UserModel> addUser(AddNewUserRequest body);
  Future<void> removeUser(int userId);
  Future<InvoiceSettingsModel> getInvoiceSettings();
  Future<InvoiceSettingsModel> setInvoiceSettings(InvoiceSettingsModel invoiceSettings);
  Future<BankAccountEntity> getBankAccount(int bankAccountId);
  Future<BankAccountModel> updateBankAccount(UpdateBankAccountRequest body);
}

@LazySingleton(as: SettingsRemoteDataSource)
class SettingsRemoteDataSourceImpl implements SettingsRemoteDataSource {
  final ApiClient client;

  SettingsRemoteDataSourceImpl({required this.client});
  @override
  Future<CompanyModel> changeCompanyInfo(ChangeCompanyInfoRequest body) async {
    const path = ApiPaths.company;

    final formData = await body.toFormData();
    final request = ApiRequest(path: path, body: formData);
    final response = await client.post(request);

    if (ResponseCode.isOk(response.statusCode)) {
      final json = response.data;
      return CompanyModel.fromJson(json);
    }

    throw ServerException(response.statusCode, response.statusMessage);
  }

  @override
  Future<CompanyModel> getCompany() async {
    const path = ApiPaths.company;
    final request = ApiRequest(path: path);
    final response = await client.get(request);

    if (ResponseCode.isOk(response.statusCode)) {
      final json = response.data;
      return CompanyModel.fromJson(json);
    }

    throw ServerException(response.statusCode, response.statusMessage);
  }

  @override
  Future<BankAccountModel> addBankAccount(AddBankAccountRequest body) async {
    const path = ApiPaths.bankAccounts;
    final request = ApiRequest(path: path, body: body.toJson());
    final response = await client.post(request);

    if (ResponseCode.isOk(response.statusCode)) {
      final json = response.data;
      return BankAccountModel.fromJson(json);
    }

    throw ServerException(response.statusCode, response.statusMessage);
  }

  @override
  Future<List<BankAccountModel>> getBankAccountsList() async {
    const path = ApiPaths.bankAccounts;
    final request = ApiRequest(path: path);
    final response = await client.get(request);

    if (ResponseCode.isOk(response.statusCode)) {
      final json = response.data;
      final responseList = PaginationListResponse.fromJson(json, BankAccountModel.fromJson);
      return responseList.data;
    }

    throw ServerException(response.statusCode, response.statusMessage);
  }

  @override
  Future<void> deleteBankAccount(int bankAccountId) async {
    final path = ApiPaths.bankAccountById(bankAccountId);
    final request = ApiRequest(path: path);
    final response = await client.delete(request);

    if (ResponseCode.isOk(response.statusCode)) {
      return;
    }

    throw ServerException(response.statusCode, response.statusMessage);
  }

  @override
  Future<UserModel> addUser(AddNewUserRequest body) async {
    const path = ApiPaths.users;
    final request = ApiRequest(path: path, body: body.toJson());
    final response = await client.post(request);

    if (ResponseCode.isOk(response.statusCode)) {
      return UserModel.fromJson(response.data);
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }

  @override
  Future<List<UserModel>> getUsersList() async {
    const path = ApiPaths.users;
    final request = ApiRequest(path: path);
    final response = await client.get(request);

    if (ResponseCode.isOk(response.statusCode)) {
      final json = response.data;
      final responseList = PaginationListResponse.fromJson(json, UserModel.fromJson);
      return responseList.data;
    }

    throw ServerException(response.statusCode, response.statusMessage);
  }

  @override
  Future<void> removeUser(int userId) async {
    final path = ApiPaths.userById(userId);
    final request = ApiRequest(path: path);
    final response = await client.delete(request);

    if (ResponseCode.isOk(response.statusCode)) {
      return;
    }

    throw ServerException(response.statusCode, response.statusMessage);
  }

  @override
  Future<InvoiceSettingsModel> getInvoiceSettings() async {
    const path = ApiPaths.invoiceSettings;
    final request = ApiRequest(path: path);
    final response = await client.get(request);

    if (ResponseCode.isOk(response.statusCode)) {
      final json = response.data;
      return InvoiceSettingsModel.fromJson(json);
    }

    throw ServerException(response.statusCode, response.statusMessage);
  }

  @override
  Future<InvoiceSettingsModel> setInvoiceSettings(InvoiceSettingsModel invoiceSettings) async {
    const path = ApiPaths.invoiceSettings;
    final request = ApiRequest(path: path, body: invoiceSettings.toJson());
    final response = await client.post(request);

    if (ResponseCode.isOk(response.statusCode)) {
      final json = response.data;
      return InvoiceSettingsModel.fromJson(json);
    }

    throw ServerException(response.statusCode, response.statusMessage);
  }

  @override
  Future<BankAccountEntity> getBankAccount(int bankAccountId) async {
    final path = ApiPaths.bankAccountById(bankAccountId);
    final request = ApiRequest(path: path);
    final response = await client.get(request);

    if (ResponseCode.isOk(response.statusCode)) {
      final json = response.data;
      return BankAccountModel.fromJson(json);
    }

    throw ServerException(response.statusCode, response.statusMessage);
  }

  @override
  Future<BankAccountModel> updateBankAccount(UpdateBankAccountRequest body) async {
    final path = ApiPaths.bankAccountById(body.id);
    final request = ApiRequest(path: path, body: body.toJson());
    final response = await client.put(request);

    if (ResponseCode.isOk(response.statusCode)) {
      final json = response.data;
      return BankAccountModel.fromJson(json);
    }

    throw ServerException(response.statusCode, response.statusMessage);
  }
}
