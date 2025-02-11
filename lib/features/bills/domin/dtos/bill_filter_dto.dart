import 'package:equatable/equatable.dart';

class BillsFilterDto extends Equatable {
  final DateTime? fromDate;
  final DateTime? toDate;

  const BillsFilterDto({required this.fromDate, required this.toDate});

  @override
  List<Object?> get props => [fromDate, toDate];
}
