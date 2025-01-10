import 'package:autro_app/core/api/api_client.dart';
import 'package:autro_app/core/api/api_paths.dart';
import 'package:autro_app/core/api/api_request.dart';
import 'package:autro_app/core/common/data/responses/pagination_list_response.dart';
import 'package:autro_app/core/errors/error_handler.dart';
import 'package:autro_app/core/errors/exceptions.dart';
import 'package:autro_app/features/settings/data/models/company_model.dart';
import 'package:autro_app/features/settings/data/models/requests/change_company_info_request.dart';
import 'package:injectable/injectable.dart';

import '../models/bank_account_model.dart';
import '../models/requests/add_bank_account_request.dart';

abstract class SettingsRemoteDataSource {
  Future<CompanyModel> changeCompanyInfo(ChangeCompanyInfoRequest body);
  Future<CompanyModel> getCompany();
  Future<BankAccountModel> addBankAccount(AddBankAccountRequest body);
  Future<List<BankAccountModel>> getBankAccountsList();
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
}
