import 'package:equatable/equatable.dart';

class BlInsturctionEntity extends Equatable {
  final int id;
  final int dealId;
  final String number;
  final DateTime date;
  final String attachmentUrl;

  const BlInsturctionEntity({
    required this.id,
    required this.dealId,
    required this.number,
    required this.date,
    required this.attachmentUrl,
  });

  @override
  List<Object?> get props => [
        id,
        dealId,
        number,
        date,
        attachmentUrl,
      ];

  bool get hasAttachment => attachmentUrl.isNotEmpty;

  bool get hasWordAttachment => attachmentUrl.split('.').last == 'doc' || attachmentUrl.split('.').last == 'docx';
  bool get hasPdfAttachment => attachmentUrl.split('.').last == 'pdf';
}
