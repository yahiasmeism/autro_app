import 'package:equatable/equatable.dart';

class BillsSummaryEntity extends Equatable {
  final int totalBillsCount;
  final double totalAmount;
  final double totalAfterVat;

  const BillsSummaryEntity({
    required this.totalBillsCount,
    required this.totalAmount,
    required this.totalAfterVat,
  });

  @override
  List<Object?> get props => [totalBillsCount, totalAmount];

  BillsSummaryEntity copyWith({
    int? totalBillsCount,
    double? totalAmount,
    double? totalAfterVat,
  }) {
    return BillsSummaryEntity(
      totalBillsCount: totalBillsCount ?? this.totalBillsCount,
      totalAmount: totalAmount ?? this.totalAmount,
      totalAfterVat: totalAfterVat ?? this.totalAfterVat,
    );
  }
}
