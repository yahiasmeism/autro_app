import 'package:autro_app/core/api/api_client.dart';
import 'package:autro_app/core/api/api_paths.dart';
import 'package:autro_app/core/api/api_request.dart';
import 'package:autro_app/core/errors/error_handler.dart';
import 'package:autro_app/core/errors/exceptions.dart';
import 'package:autro_app/features/settings/data/models/company_model.dart';
import 'package:autro_app/features/settings/data/models/requests/change_company_info_request.dart';
import 'package:injectable/injectable.dart';

abstract class SettingsRemoteDataSource {
  Future<CompanyModel> changeCompanyInfo(ChangeCompanyInfoRequest body);
  Future<CompanyModel> getCompany();
}


@LazySingleton(as: SettingsRemoteDataSource)
class SettingsRemoteDataSourceImpl implements SettingsRemoteDataSource {
  final ApiClient client;

  SettingsRemoteDataSourceImpl({required this.client});
  @override
  Future<CompanyModel> changeCompanyInfo(ChangeCompanyInfoRequest body) async {
    const path = ApiPaths.company;

    final request = ApiRequest(path: path, body: body.toFormData());
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
}
