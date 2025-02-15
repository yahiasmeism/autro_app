import 'package:autro_app/core/api/api_client.dart';
import 'package:autro_app/core/common/data/responses/pagination_list_response.dart';
import 'package:autro_app/core/errors/exceptions.dart';
import 'package:autro_app/features/payment/data/requests/update_payment_requst.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api/api_paths.dart';
import '../../../../core/api/api_request.dart';
import '../../../../core/errors/error_handler.dart';
import '../models/payment_model.dart';

abstract class PaymentsRemoteDataSources {
  Future<List<PaymentModel>> getPayments(int dealId);
  Future<PaymentModel> updatePayment(UpdatePaymentRequst body);
}

@LazySingleton(as: PaymentsRemoteDataSources)
class PaymentsRemoteDataSourcesImpl implements PaymentsRemoteDataSources {
  final ApiClient apiClient;

  PaymentsRemoteDataSourcesImpl({required this.apiClient});
  @override
  Future<List<PaymentModel>> getPayments(int dealId) async {
    final path = ApiPaths.dealPayments(dealId);
    final request = ApiRequest(path: path);
    final response = await apiClient.get(request);

    if (ResponseCode.isOk(response.statusCode)) {
      final json = response.data;
      final list = PaginationListResponse.fromJson(json, PaymentModel.fromJson);
      return list.data;
    }

    throw ServerException(response.statusCode, response.statusMessage);
  }

  @override
  Future<PaymentModel> updatePayment(UpdatePaymentRequst body) async {
    final path = ApiPaths.dealPaymentById(body.paymentId);
    final request = ApiRequest(path: path, body: body.toJson());
    final response = await apiClient.put(request);

    if (ResponseCode.isOk(response.statusCode)) {
      final json = response.data;
      return PaymentModel.fromJson(json);
    }

    throw ServerException(response.statusCode, response.statusMessage);
  }
}
