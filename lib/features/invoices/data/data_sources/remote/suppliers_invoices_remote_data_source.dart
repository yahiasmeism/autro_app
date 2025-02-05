import 'package:autro_app/core/api/api_request.dart';
import 'package:autro_app/core/common/data/responses/pagination_list_response.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/api/api_client.dart';
import '../../../../../core/api/api_paths.dart';
import '../../../../../core/errors/error_handler.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../models/supplier_invoice_model.dart';
import '../../models/requests/create_supplier_invoice_request.dart';
import '../../models/requests/get_suppliers_invoices_list_request.dart';
import '../../models/requests/update_supplier_invoice_request.dart';

abstract class SuppliersInvoicesRemoteDataSource {
  Future<SupplierInvoiceModel> createInvoice(CreateSupplierInvoiceRequest body);
  Future<Unit> deleteInvoice(int invoiceId);
  Future<SupplierInvoiceModel> getInvoiceById(int invoiceId);
  Future<PaginationListResponse<SupplierInvoiceModel>> getInvoicesList(GetSuppliersInvoicesListRequest body);
  Future<SupplierInvoiceModel> updateInvoice(UpdateSupplierInvoiceRequest body);
}

@LazySingleton(as: SuppliersInvoicesRemoteDataSource)
class SuppliersInvoicesRemoteDataSourceImpl implements SuppliersInvoicesRemoteDataSource {
  final ApiClient client;

  SuppliersInvoicesRemoteDataSourceImpl({required this.client});
  @override
  Future<SupplierInvoiceModel> createInvoice(CreateSupplierInvoiceRequest body) async {
    const path = ApiPaths.supplierInvoices;
    final json = await body.toFormDate();
    final request = ApiRequest(path: path, body: json);
    final response = await client.post(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return SupplierInvoiceModel.fromJson(response.data);
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }

  @override
  Future<Unit> deleteInvoice(int invoiceId) async {
    final path = ApiPaths.supplierInvoicesById(invoiceId);
    final request = ApiRequest(path: path);
    final response = await client.delete(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return unit;
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }

  @override
  Future<SupplierInvoiceModel> getInvoiceById(int invoiceId) async {
    final path = ApiPaths.supplierInvoicesById(invoiceId);
    final request = ApiRequest(path: path);
    final response = await client.get(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return SupplierInvoiceModel.fromJson(response.data);
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }

  @override
  Future<PaginationListResponse<SupplierInvoiceModel>> getInvoicesList(GetSuppliersInvoicesListRequest body) async {
    const path = ApiPaths.supplierInvoices;
    final request = ApiRequest(path: path, queryParameters: body.toJson());
    final response = await client.get(request);
    if (ResponseCode.isOk(response.statusCode)) {
      final json = response.data;
      final responseList = PaginationListResponse.fromJson(json, SupplierInvoiceModel.fromJson);
      return responseList;
    }
    throw ServerException(response.statusCode, response.statusMessage);
  }

  @override
  Future<SupplierInvoiceModel> updateInvoice(UpdateSupplierInvoiceRequest body) async {
    final path = ApiPaths.supplierInvoicesById(body.id);
    final request = ApiRequest(path: path, body: await body.toFormDate());
    final response = await client.post(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return SupplierInvoiceModel.fromJson(response.data);
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }
}
