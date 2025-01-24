import 'package:equatable/equatable.dart';

class BillsSummaryEntity extends Equatable {
  final int totalBillsCount;
  final double totalAmount;

  const BillsSummaryEntity({
    required this.totalBillsCount,
    required this.totalAmount,
  });

  @override
  List<Object?> get props => [totalBillsCount, totalAmount];

  BillsSummaryEntity copyWith({
    int? totalBillsCount,
    double? totalAmount,
  }) {
    return BillsSummaryEntity(
      totalBillsCount: totalBillsCount ?? this.totalBillsCount,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }
}
