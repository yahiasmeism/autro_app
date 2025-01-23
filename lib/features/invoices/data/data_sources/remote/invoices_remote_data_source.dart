import 'package:autro_app/core/api/api_request.dart';
import 'package:autro_app/core/common/data/responses/pagination_list_response.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/api/api_client.dart';
import '../../../../../core/api/api_paths.dart';
import '../../../../../core/errors/error_handler.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../models/invoice_model.dart';
import '../../models/requests/create_invoice_request.dart';
import '../../models/requests/get_invoices_list_request.dart';
import '../../models/requests/update_invoice_request.dart';

abstract class InvoicesRemoteDataSource {
  Future<InvoiceModel> createInvoice(CreateInvoiceRequest body);
  Future<Unit> deleteInvoice(int invoiceId);
  Future<InvoiceModel> getInvoiceById(int invoiceId);
  Future<PaginationListResponse<InvoiceModel>> getInvoicesList(GetInvoicesListRequest body);
  Future<InvoiceModel> updateInvoice(UpdateInvoiceRequest body);
}

@LazySingleton(as: InvoicesRemoteDataSource)
class InvoicesRemoteDataSourceImpl implements InvoicesRemoteDataSource {
  final ApiClient client;

  InvoicesRemoteDataSourceImpl({required this.client});
  @override
  Future<InvoiceModel> createInvoice(CreateInvoiceRequest body) async {
    const path = ApiPaths.invoices;
    final json = body.toJson();
    final request = ApiRequest(path: path, body: json);
    final response = await client.post(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return InvoiceModel.fromJson(response.data);
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }

  @override
  Future<Unit> deleteInvoice(int invoiceId) async {
    final path = ApiPaths.invoiceById(invoiceId);
    final request = ApiRequest(path: path);
    final response = await client.delete(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return unit;
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }

  @override
  Future<InvoiceModel> getInvoiceById(int invoiceId) async {
    final path = ApiPaths.invoiceById(invoiceId);
    final request = ApiRequest(path: path);
    final response = await client.get(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return InvoiceModel.fromJson(response.data);
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }

  @override
  Future<PaginationListResponse<InvoiceModel>> getInvoicesList(GetInvoicesListRequest body) async {
    const path = ApiPaths.invoices;
    final request = ApiRequest(path: path, queryParameters: body.toJson());
    final response = await client.get(request);
    if (ResponseCode.isOk(response.statusCode)) {
      final json = response.data;
      final responseList = PaginationListResponse.fromJson(json, InvoiceModel.fromJson);
      return responseList;
    }
    throw ServerException(response.statusCode, response.statusMessage);
  }

  @override
  Future<InvoiceModel> updateInvoice(UpdateInvoiceRequest body) async {
    final path = ApiPaths.invoiceById(body.id);
    final request = ApiRequest(path: path, body: body.toJson());
    final response = await client.put(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return InvoiceModel.fromJson(response.data);
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }
}
