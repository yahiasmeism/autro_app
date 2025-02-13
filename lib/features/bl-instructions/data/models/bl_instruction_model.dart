import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/extensions/num_extension.dart';
import 'package:autro_app/core/extensions/string_extension.dart';
import 'package:autro_app/core/interfaces/mapable.dart';

import '../../domin/entities/bl_insturction_entity.dart';

class BlInsturctionModel extends BlInsturctionEntity implements BaseMapable {
  const BlInsturctionModel({
    required super.id,
    required super.dealId,
    required super.number,
    required super.date,
    required super.attachmentUrl,
  });

  factory BlInsturctionModel.fromJson(Map<String, dynamic> json) => BlInsturctionModel(
        id: (json['id'] as int?).toIntOrZero,
        dealId: (json['deal_id'] as int?).toIntOrZero,
        number: (json['number'] as String?).orEmpty,
        date: DateTime.tryParse((json['date'] as String?).orEmpty).orDefault,
        attachmentUrl: (json['attachment'] as String?).orEmpty,
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'deal_id': dealId,
      'number': number,
      'date': date.formattedDateYYYYMMDD,
      'attachment': attachmentUrl,
    };
  }
}
