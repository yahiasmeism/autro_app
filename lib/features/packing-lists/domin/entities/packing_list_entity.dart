import 'package:autro_app/features/packing-lists/domin/entities/packing_list_entity_descirption.dart';
import 'package:equatable/equatable.dart';

class PackingListEntity extends Equatable {
  final int id;
  final String details;
  final List<PackingListDescriptionEntity> descriptions;

  const PackingListEntity({required this.details, required this.descriptions, required this.id});

  @override
  List<Object?> get props => [details, descriptions, id];
}
