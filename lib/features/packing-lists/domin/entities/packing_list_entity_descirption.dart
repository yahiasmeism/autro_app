import 'package:equatable/equatable.dart';

class PackingListDescriptionEntity extends Equatable {
  final int packingListId;
  final int id;
  final String containerNumber;
  final double emptyContainerWeight;
  final double weight;
  final DateTime date;
  final String percento;
  final int itemsCount;
  final String type;

  double get vgm => weight * emptyContainerWeight;

  const PackingListDescriptionEntity({
    required this.packingListId,
    required this.containerNumber,
    required this.weight,
    required this.emptyContainerWeight,
    required this.itemsCount,
    required this.date,
    required this.percento,
    required this.id,
    required this.type,
  });

  @override
  List<Object?> get props => [
        packingListId,
        containerNumber,
        weight,
        vgm,
        date,
        percento,
        id,
        type,
        itemsCount,
      ];
}
