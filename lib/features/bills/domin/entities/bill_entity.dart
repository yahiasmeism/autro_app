import 'package:equatable/equatable.dart';

class BillEntity extends Equatable {
  final String id;
  final String vendor;
  final double amount;
  final String notes;
  final DateTime date;
  final DateTime createdAt;
  final DateTime updatedAt;

  const BillEntity({
    required this.id,
    required this.vendor,
    required this.amount,
    required this.notes,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  List<Object> get props => [];
}
