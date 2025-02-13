import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:dio/dio.dart';

import '../../../domin/usecases/create_bl_instruction_use_case.dart';

class CreateBlInsturctionRequest extends CreateBlInsturctionUseCaseParams implements RequestMapable {
  const CreateBlInsturctionRequest({
    required super.dealId,
    required super.number,
    required super.date,
    required super.attachmentPath,
    required super.deleteAttachment,
  });

  factory CreateBlInsturctionRequest.fromParams(CreateBlInsturctionUseCaseParams params) {
    return CreateBlInsturctionRequest(
      dealId: params.dealId,
      number: params.number,
      date: params.date,
      attachmentPath: params.attachmentPath,
      deleteAttachment: params.deleteAttachment,
    );
  }

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      ...toJson(),
      if (attachmentPath != null) 'attachment': await MultipartFile.fromFile(attachmentPath!),
    });
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'deal_id': dealId,
      'number': number,
      'date': date.formattedDateYYYYMMDD,
    };
  }
}
