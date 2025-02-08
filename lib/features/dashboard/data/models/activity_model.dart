import 'package:autro_app/core/extensions/activity_type_extension.dart';
import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/extensions/map_extension.dart';
import 'package:autro_app/core/extensions/module_type_extension.dart';
import 'package:autro_app/core/extensions/num_extension.dart';
import 'package:autro_app/core/extensions/string_extension.dart';
import 'package:autro_app/features/authentication/data/models/user_model.dart';
import 'package:autro_app/features/dashboard/domin/entities/activity_entity.dart';
import 'package:autro_app/features/deals/data/models/deal_model.dart';

class ActivityModel extends ActivityEntity {
  const ActivityModel({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.type,
    required super.module,
    required super.title,
    required super.moduleId,
    required super.byUser,
    required super.deal,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) => ActivityModel(
        id: (json['id'] as int?).toIntOrZero,
        createdAt: DateTime.tryParse((json['created_at'] as String?).orEmpty).orDefault,
        updatedAt: DateTime.tryParse((json['updated_at'] as String?).orEmpty).orDefault,
        type: ActivityTypeX.fromString((json['type'] as String?).orEmpty),
        module: ModuleTypeX.fromString((json['module'] as String?).orEmpty),
        title: (json['title'] as String?).orEmpty,
        moduleId: (json['module_id'] as int?).toIntOrZero,
        byUser: UserModel.fromJson((json['user'] as Map<String, dynamic>?).orEmpty),
        deal: DealModel.fromJson((json['deal'] as Map<String, dynamic>?).orEmpty),
      );
}
