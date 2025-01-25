import 'package:autro_app/core/api/api_client.dart';
import 'package:autro_app/core/api/api_paths.dart';
import 'package:autro_app/core/api/api_request.dart';
import 'package:autro_app/core/common/data/responses/pagination_list_response.dart';
import 'package:autro_app/core/errors/error_handler.dart';
import 'package:autro_app/core/errors/exceptions.dart';
import 'package:autro_app/features/shipping-invoices/data/models/requests/create_shipping_invoice_request.dart';
import 'package:injectable/injectable.dart';

import '../../models/requests/get_shipping_invoices_list_request.dart';
import '../../models/requests/update_shipping_invoice_request.dart';
import '../../models/shipping_invoice_model.dart';

abstract class ShippingInvoicesRemoteDateSource {
  Future<PaginationListResponse<ShippingInvoiceModel>> getShippingInvoicesList(GetShippingInvoicesListRequest body);

  Future<ShippingInvoiceModel> getShippingInvoice(int id);

  Future<ShippingInvoiceModel> createShippingInvoice(CreateShippingInvoiceRequest body);

  Future<ShippingInvoiceModel> updateShippingInvoice(UpdateShippingInvoiceRequest body);

  Future<void> deleteShippingInvoice(int id);
}

@LazySingleton(as: ShippingInvoicesRemoteDateSource)
class ShippingInvoicesRemoteDateSourceImpl implements ShippingInvoicesRemoteDateSource {
  final ApiClient client;

  ShippingInvoicesRemoteDateSourceImpl({required this.client});
  @override
  Future<ShippingInvoiceModel> createShippingInvoice(CreateShippingInvoiceRequest body) async {
    const path = ApiPaths.shippingInvoices;
    final request = ApiRequest(path: path, body: await body.toFormData());
    final response = await client.post(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return ShippingInvoiceModel.fromJson(response.data);
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }

  @override
  Future<void> deleteShippingInvoice(int id) async {
    final path = ApiPaths.shippingInvoiceById(id);
    final request = ApiRequest(path: path);
    final response = await client.delete(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return;
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }

  @override
  Future<ShippingInvoiceModel> getShippingInvoice(int id) async {
    final path = ApiPaths.shippingInvoiceById(id);
    final request = ApiRequest(path: path);
    final response = await client.get(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return ShippingInvoiceModel.fromJson(response.data);
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }

  @override
  Future<PaginationListResponse<ShippingInvoiceModel>> getShippingInvoicesList(GetShippingInvoicesListRequest body) async {
    const path = ApiPaths.shippingInvoices;
    final request = ApiRequest(path: path, queryParameters: body.toJson());
    final response = await client.get(request);
    if (ResponseCode.isOk(response.statusCode)) {
      final json = response.data;
      final responseList = PaginationListResponse.fromJson(json, ShippingInvoiceModel.fromJson);
      return responseList;
    }
    throw ServerException(response.statusCode, response.statusMessage);
  }

  @override
  Future<ShippingInvoiceModel> updateShippingInvoice(UpdateShippingInvoiceRequest body) async {
    final path = ApiPaths.shippingInvoiceById(body.id);
    final request = ApiRequest(path: path, body: await body.toFormData());
    final response = await client.put(request);
    if (ResponseCode.isOk(response.statusCode)) {
      return ShippingInvoiceModel.fromJson(response.data);
    } else {
      throw ServerException(response.statusCode, response.statusMessage);
    }
  }
}
