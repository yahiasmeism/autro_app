import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/deals/domin/use_cases/create_deal_bill_use_case.dart';
import 'package:dio/dio.dart';

class CreateDealBillRequest extends CreateDealBillUseCaseParams implements RequestMapable {
  const CreateDealBillRequest({
    // required super.number,
    required super.vendor,
    required super.amount,
    required super.notes,
    required super.date,
    required super.attachmentPath,
    required super.dealId,
  });

  factory CreateDealBillRequest.fromParams(CreateDealBillUseCaseParams params) => CreateDealBillRequest(
        // number: params.number,
        vendor: params.vendor,
        amount: params.amount,
        notes: params.notes,
        date: params.date,
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
