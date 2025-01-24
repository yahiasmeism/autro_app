import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class BillEntity extends Equatable {
  final int id;
  final String vendor;
  final double amount;
  final String notes;
  final DateTime date;
  final DateTime createdAt;
  final DateTime updatedAt;

  String get formattedDate => DateFormat('MMM d, y').format(date);

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
