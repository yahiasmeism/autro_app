import 'package:equatable/equatable.dart';

class DealBillEntity extends Equatable {
  final int id;
  final int dealId;
  final String vendor;
  final double amount;
  final String notes;
  final DateTime date;
  final String attachmentUrl;

  const DealBillEntity({
    required this.id,
    required this.attachmentUrl,
    required this.dealId,
    required this.vendor,
    required this.amount,
    required this.notes,
    required this.date,
  });
  @override
  List<Object?> get props => [
        id,
        dealId,
        vendor,
        amount,
        notes,
        date,
        attachmentUrl,
      ];

  bool get hasAttachment => attachmentUrl.isNotEmpty;

  bool get hasImageAttachment =>
      attachmentUrl.split('.').last == 'jpg' || attachmentUrl.split('.').last == 'png' || attachmentUrl.split('.').last == 'jpeg';

  bool get hasPdfAttachment => attachmentUrl.split('.').last == 'pdf';
}
