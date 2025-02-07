import 'package:autro_app/features/packing-lists/domin/entities/packing_list_entity_descirption.dart';
import 'package:equatable/equatable.dart';

class PackingListEntity extends Equatable {
  final int id;
  final int dealId;
  final String number;
  final String details;
  final List<PackingListDescriptionEntity> descriptions;

  const PackingListEntity(
      {required this.id, required this.dealId, required this.number, required this.details, required this.descriptions});

  @override
  List<Object?> get props => [details, descriptions, id, dealId, number];

  double get totalWeight => descriptions.fold(0, (previousValue, element) => previousValue + element.weight);
}
