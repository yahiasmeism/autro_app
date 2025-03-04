import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/bills/domin/use_cases/add_bill_use_case.dart';
import 'package:dio/dio.dart';

class AddBillRequest extends AddBillUseCaseParams implements RequestMapable {
  const AddBillRequest({
    required super.vendor,
    required super.amount,
    required super.notes,
    required super.date,
    required super.attachmentPath,
    required super.vat,
    required super.status,
  });

  factory AddBillRequest.fromParams(AddBillUseCaseParams params) => AddBillRequest(
        vendor: params.vendor,
        amount: params.amount,
        notes: params.notes,
        date: params.date,
        attachmentPath: params.attachmentPath,
        vat: params.vat,
        status: params.status,
      );

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      ...toJson(),
      if (attachmentPath != null) 'attachment': await MultipartFile.fromFile(attachmentPath!),
    });
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'status': status.toLowerCase(),
      'vendor': vendor,
      'amount': amount,
      'notes': notes,
      'date': date.formattedDateYYYYMMDD,
      'vat': vat,
    };
  }
}
