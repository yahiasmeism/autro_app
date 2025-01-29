import 'package:autro_app/core/api/api_request.dart';
import 'package:autro_app/core/common/data/responses/pagination_list_response.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/api/api_client.dart';
import '../../../../../core/api/api_paths.dart';
import '../../../../../core/errors/error_handler.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../models/customer_proforma_model.dart';
import '../../models/requests/create_customer_proforma_request.dart';
import '../../models/requests/get_customers_proformas_list_request.dart';
import '../../models/requests/update_customer_proforma_request.dart';

abstract class CustomersProformasRemoteDataSource {
  Future<CustomerProformaModel> createCustomerProforma(CreateCustomerProformaRequest body);
  Future<Unit> deleteCustomerProformaProforma(int proformaId);
  Future<CustomerProformaModel> getCustomerProformaById(int proformaId);
  Future<PaginationListResponse<CustomerProformaModel>> getCustomerProformasList(GetCustomersProformasListRequest body);
  Future<CustomerProformaModel> updateCustomerProforma(UpdateCustomerProformaRequest body);
}

@LazySingleton(as: CustomersProformasRemoteDataSource)
class CustomersProformasRemoteDataSourceImpl implements CustomersProformasRemoteDataSource {
  final ApiClient client;

  CustomersProformasRemoteDataSourceImpl({required this.client});
  @override
  Future<CustomerProformaModel> createCustomerProforma(CreateCustomerProformaRequest body) async {
    const path = ApiPaths.proformas;
    final json = body.toJson();
    final request = ApiRequest(path: path, body: json);
    final response = await client.post(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return CustomerProformaModel.fromJson(response.data);
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }

  @override
  Future<Unit> deleteCustomerProformaProforma(int proformaId) async {
    final path = ApiPaths.proformaById(proformaId);
    final request = ApiRequest(path: path);
    final response = await client.delete(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return unit;
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }

  @override
  Future<CustomerProformaModel> getCustomerProformaById(int proformaId) async {
    final path = ApiPaths.proformaById(proformaId);
    final request = ApiRequest(path: path);
    final response = await client.get(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return CustomerProformaModel.fromJson(response.data);
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }

  @override
  Future<PaginationListResponse<CustomerProformaModel>> getCustomerProformasList(GetCustomersProformasListRequest body) async {
    const path = ApiPaths.proformas;
    final request = ApiRequest(path: path, queryParameters: body.toJson());
    final response = await client.get(request);
    if (ResponseCode.isOk(response.statusCode)) {
      final json = response.data;
      final responseList = PaginationListResponse.fromJson(json, CustomerProformaModel.fromJson);
      return responseList;
    }
    throw ServerException(response.statusCode, response.statusMessage);
  }

  @override
  Future<CustomerProformaModel> updateCustomerProforma(UpdateCustomerProformaRequest body) async {
    final path = ApiPaths.proformaById(body.id);
    final request = ApiRequest(path: path, body: body.toJson());
    final response = await client.put(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return CustomerProformaModel.fromJson(response.data);
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }
}
