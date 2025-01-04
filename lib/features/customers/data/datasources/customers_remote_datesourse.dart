import 'package:autro_app/core/api/api_client.dart';
import 'package:autro_app/core/api/api_paths.dart';
import 'package:autro_app/core/api/api_request.dart';
import 'package:autro_app/core/common/data/responses/pagination_list_response.dart';
import 'package:autro_app/core/errors/error_handler.dart';
import 'package:autro_app/core/errors/exceptions.dart';
import 'package:autro_app/features/customers/data/models/customer_model.dart';
import 'package:autro_app/features/customers/data/models/requests/create_customer_request.dart';
import 'package:autro_app/features/customers/data/models/requests/get_customers_list_request.dart';
import 'package:autro_app/features/customers/data/models/requests/update_customer_request.dart';
import 'package:injectable/injectable.dart';

abstract class CustomersRemoteDataSource {
  Future<PaginationListResponse<CustomerModel>> getCustomersList(GetCustomersListRequest body);
  Future<CustomerModel> createCustomer(CreateCustomerRequest body);
  Future<CustomerModel> updateCustomer(UpdateCustomerRequest body);
  Future<void> deleteCustomer(int customerId);
  Future<CustomerModel> getCustomer(int customerId);
}

@LazySingleton(as: CustomersRemoteDataSource)
class CustomersRemoteDataSourceImpl implements CustomersRemoteDataSource {
  final ApiClient apiClient;

  CustomersRemoteDataSourceImpl({required this.apiClient});
  @override
  Future<CustomerModel> createCustomer(CreateCustomerRequest body) async {
    const path = ApiPaths.customers;
    final request = ApiRequest(path: path, body: body.toJson());
    final response = await apiClient.post(request);

    if (ResponseCode.isOk(response.statusCode)) {
      return CustomerModel.fromJson(response.data);
    }

    throw ServerException(response.statusCode, response.statusMessage);
  }

  @override
  Future<void> deleteCustomer(int customerId) async {
    final path = ApiPaths.customerById(customerId);
    final request = ApiRequest(path: path);
    final response = await apiClient.delete(request);

    if (ResponseCode.isOk(response.statusCode)) {
      return;
    }

    throw ServerException(response.statusCode, response.statusMessage);
  }

  @override
  Future<CustomerModel> getCustomer(int customerId) async {
    final path = ApiPaths.customerById(customerId);
    final request = ApiRequest(path: path);
    final response = await apiClient.get(request);

    if (ResponseCode.isOk(response.statusCode)) {
      return CustomerModel.fromJson(response.data);
    }

    throw ServerException(response.statusCode, response.statusMessage);
  }

  @override
  Future<PaginationListResponse<CustomerModel>> getCustomersList(GetCustomersListRequest body) async {
    const path = ApiPaths.customers;
    final request = ApiRequest(path: path, queryParameters: body.toJson());
    final response = await apiClient.get(request);
    if (ResponseCode.isOk(response.statusCode)) {
      final json = response.data;
      final responseList = PaginationListResponse.fromJson(json, CustomerModel.fromJson);
      return responseList;
    }
    throw ServerException(response.statusCode, response.statusMessage);
  }

  @override
  Future<CustomerModel> updateCustomer(UpdateCustomerRequest body) async {
    final path = ApiPaths.customerById(body.customerModel.id);
    final request = ApiRequest(path: path, body: body.toJson());
    final response = await apiClient.put(request);

    if (ResponseCode.isOk(response.statusCode)) {
      return CustomerModel.fromJson(response.data);
    }

    throw ServerException(response.statusCode, response.statusMessage);
  }
}
