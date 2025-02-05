import 'package:autro_app/core/api/api_request.dart';
import 'package:autro_app/core/common/data/responses/pagination_list_response.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/api/api_client.dart';
import '../../../../../core/api/api_paths.dart';
import '../../../../../core/errors/error_handler.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../models/customer_invoice_model.dart';
import '../../models/requests/create_customer_invoice_request.dart';
import '../../models/requests/get_customers_invoices_list_request.dart';
import '../../models/requests/update_customer_invoice_request.dart';

abstract class CustomersInvoicesRemoteDataSource {
  Future<CustomerInvoiceModel> createInvoice(CreateCustomerInvoiceRequest body);
  Future<Unit> deleteInvoice(int invoiceId);
  Future<CustomerInvoiceModel> getInvoiceById(int invoiceId);
  Future<PaginationListResponse<CustomerInvoiceModel>> getInvoicesList(GetCustomersInvoicesListRequest body);
  Future<CustomerInvoiceModel> updateInvoice(UpdateCustomerInvoiceRequest body);
}

@LazySingleton(as: CustomersInvoicesRemoteDataSource)
class CustomersInvoicesRemoteDataSourceImpl implements CustomersInvoicesRemoteDataSource {
  final ApiClient client;

  CustomersInvoicesRemoteDataSourceImpl({required this.client});
  @override
  Future<CustomerInvoiceModel> createInvoice(CreateCustomerInvoiceRequest body) async {
    const path = ApiPaths.customerInvoices;
    final json = body.toJson();
    final request = ApiRequest(path: path, body: json);
    final response = await client.post(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return CustomerInvoiceModel.fromJson(response.data);
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }

  @override
  Future<Unit> deleteInvoice(int invoiceId) async {
    final path = ApiPaths.customerInvoiceById(invoiceId);
    final request = ApiRequest(path: path);
    final response = await client.delete(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return unit;
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }

  @override
  Future<CustomerInvoiceModel> getInvoiceById(int invoiceId) async {
    final path = ApiPaths.customerInvoiceById(invoiceId);
    final request = ApiRequest(path: path);
    final response = await client.get(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return CustomerInvoiceModel.fromJson(response.data);
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }

  @override
  Future<PaginationListResponse<CustomerInvoiceModel>> getInvoicesList(GetCustomersInvoicesListRequest body) async {
    const path = ApiPaths.customerInvoices;
    final request = ApiRequest(path: path, queryParameters: body.toJson());
    final response = await client.get(request);
    if (ResponseCode.isOk(response.statusCode)) {
      final json = response.data;
      final responseList = PaginationListResponse.fromJson(json, CustomerInvoiceModel.fromJson);
      return responseList;
    }
    throw ServerException(response.statusCode, response.statusMessage);
  }

  @override
  Future<CustomerInvoiceModel> updateInvoice(UpdateCustomerInvoiceRequest body) async {
    final path = ApiPaths.customerInvoiceById(body.id);
    final request = ApiRequest(path: path, body: body.toJson());
    final response = await client.put(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return CustomerInvoiceModel.fromJson(response.data);
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }
}
