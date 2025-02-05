import 'package:equatable/equatable.dart';

class PackingListEntityDescirption extends Equatable {
  final int packingListId;
  final String containerNumber;
  final double weight;
  final double vgm;
  final DateTime date;
  final int percent;

  

  const PackingListEntityDescirption({
    required this.packingListId,
    required this.containerNumber,
    required this.weight,
    required this.vgm,
    required this.date,
    required this.percent,
  });

  @override
  List<Object?> get props => [
        packingListId,
        containerNumber,
        weight,
        vgm,
        date,
        percent,
      ];
}
