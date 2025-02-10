import 'package:autro_app/features/customers/domin/entities/customer_entity.dart';
import 'package:autro_app/features/packing-lists/domin/entities/packing_list_entity_descirption.dart';
import 'package:equatable/equatable.dart';

class PackingListEntity extends Equatable {
  final int id;
  final int dealId;
  final String number;
  final String details;
  final CustomerEntity customer;
  final String taxId;
  final List<PackingListDescriptionEntity> descriptions;

  const PackingListEntity({
    required this.id,
    required this.dealId,
    required this.number,
    required this.details,
    required this.descriptions,
    required this.customer,
    required this.taxId,
  });

  @override
  List<Object?> get props => [details, descriptions, id, dealId, number, customer, taxId];

  double get totalWeight => descriptions.fold(0, (previousValue, element) => previousValue + element.weight);
}
