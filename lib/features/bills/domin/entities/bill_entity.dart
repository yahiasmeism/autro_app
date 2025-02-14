import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class BillEntity extends Equatable {
  final int id;
  final String vendor;
  final double amount;
  final String notes;
  final DateTime date;
  final double vat;
  final String attachmentUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  String get formattedDate => DateFormat('MMM d, y').format(date);

  const BillEntity({
    required this.id,
    required this.attachmentUrl,
    required this.vendor,
    required this.amount,
    required this.vat,
    required this.notes,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  List<Object> get props => [
        id,
        vendor,
        amount,
        notes,
        date,
        createdAt,
        updatedAt,
        vat,
      ];

  BillEntity copyWith({
    int? id,
    String? vendor,
    double? amount,
    double? vat,
    String? notes,
    DateTime? date,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? attachmentUrl,
  }) {
    return BillEntity(
      vat: vat ?? this.vat,
      id: id ?? this.id,
      vendor: vendor ?? this.vendor,
      amount: amount ?? this.amount,
      notes: notes ?? this.notes,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      attachmentUrl: attachmentUrl ?? this.attachmentUrl,

    );
  }
}
