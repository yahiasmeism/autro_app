import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/features/authentication/data/models/user_model.dart';
import 'package:autro_app/features/deals/domin/entities/deal_entity.dart';
import 'package:equatable/equatable.dart';

class ActivityEntity extends Equatable {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ActivityType type;
  final ModuleType module;
  final String? title;
  final int moduleId;
  final UserModel byUser;
  final DealEntity? deal;

  const ActivityEntity({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
    required this.module,
    required this.title,
    required this.moduleId,
    required this.byUser,
    required this.deal,
  });

  @override
  List<Object?> get props => [
        id,
        createdAt,
        updatedAt,
        type,
        module,
        title,
        moduleId,
        byUser,
        deal,
      ];
}
