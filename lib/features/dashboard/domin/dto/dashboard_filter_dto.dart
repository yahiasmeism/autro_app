import 'package:equatable/equatable.dart';

class DashboardFilterDto extends Equatable {
  final DateTime? fromDate;
  final DateTime? toDate;

  const DashboardFilterDto({required this.fromDate, required this.toDate});

  @override
  List<Object?> get props => [fromDate, toDate];
}
