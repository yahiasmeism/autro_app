import 'package:equatable/equatable.dart';

class PackingListDescriptionEntity extends Equatable {
  final int packingListId;
  final int id;
  final String containerNumber;
  final double weight;
  final double vgm;
  final DateTime date;
  final double percent;

  const PackingListDescriptionEntity({
    required this.packingListId,
    required this.containerNumber,
    required this.weight,
    required this.vgm,
    required this.date,
    required this.percent,
    required this.id,
  });

  @override
  List<Object?> get props => [
        packingListId,
        containerNumber,
        weight,
        vgm,
        date,
        percent,
        id,
      ];
}
