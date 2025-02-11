import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/bills/domin/use_cases/update_bill_use_case.dart';
import 'package:dio/dio.dart';

class UpdateBillRequest extends UpdateBillUseCaseParams implements RequestMapable {
  const UpdateBillRequest({
    required super.id,
    required super.vendor,
    required super.amount,
    required super.notes,
    required super.date,
    required super.attachmentPath,
    required super.deleteAttachment,
  });

  factory UpdateBillRequest.fromParams(UpdateBillUseCaseParams params) => UpdateBillRequest(
        id: params.id,
        vendor: params.vendor,
        amount: params.amount,
        notes: params.notes,
        date: params.date,
        attachmentPath: params.attachmentPath,
        deleteAttachment: params.deleteAttachment,
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
      'vendor': vendor,
      'amount': amount,
      'notes': notes,
      'date': date.formattedDateYYYYMMDD,
      'delete_attachment': deleteAttachment,
    };
  }
}
