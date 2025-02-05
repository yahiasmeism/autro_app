import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/deals/domin/use_cases/update_deal_bill_use_case.dart';
import 'package:dio/dio.dart';

class UpdateDealBillRequest extends UpdateDealBillUseCaseParams implements RequestMapable {
  const UpdateDealBillRequest({
    required super.id,
    // required super.number,
    required super.vendor,
    required super.amount,
    required super.notes,
    required super.date,
    required super.deleteAttachemnt,
    required super.attachmentPath,
    required super.dealId,
  });

  factory UpdateDealBillRequest.fromParams(UpdateDealBillUseCaseParams params) => UpdateDealBillRequest(
        id: params.id,
        // number: params.number,
        vendor: params.vendor,
        amount: params.amount,
        notes: params.notes,
        date: params.date,
        deleteAttachemnt: params.deleteAttachemnt,
        attachmentPath: params.attachmentPath,
        dealId: params.dealId,
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      // "number": number,
      "vendor": vendor,
      "amount": amount,
      "notes": notes,
      "date": date.formattedDateYYYYMMDD,
      "delete_attachment": deleteAttachemnt,
    };
  }

  Future<FormData> toFormData() async {
    return FormData.fromMap(
      {
        ...toJson(),
        if (attachmentPath != null) 'attachment': await MultipartFile.fromFile(attachmentPath!),
      },
    );
  }
}
