import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:dio/dio.dart';

import '../../../domin/usecases/update_bl_instruction_use_case.dart';

class UpdateBlInsturctionRequest extends UpdateBlInsturctionUseCaseParams implements RequestMapable {
  const UpdateBlInsturctionRequest({
    required super.dealId,
    required super.number,
    required super.date,
    required super.attachmentPath,
    required super.deleteAttachment,
    required super.id,
  });

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      ...toJson(),
      if (attachmentPath != null) 'attachment': await MultipartFile.fromFile(attachmentPath!),
    });
  }

  factory UpdateBlInsturctionRequest.fromParams(UpdateBlInsturctionUseCaseParams params) => UpdateBlInsturctionRequest(
        dealId: params.dealId,
        number: params.number,
        date: params.date,
        attachmentPath: params.attachmentPath,
        deleteAttachment: params.deleteAttachment,
        id: params.id,
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      'deal_id': dealId,
      'number': number,
      'date': date.formattedDateYYYYMMDD,
      'delete_attachment': deleteAttachment,
    };
  }
}
