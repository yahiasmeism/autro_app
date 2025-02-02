import 'package:equatable/equatable.dart';

class BankAccountEntity extends Equatable {
  final int id;
  final String accountNumber;
  final String bankName;
  final String swiftCode;

  const BankAccountEntity({
    required this.id,
    required this.accountNumber,
    required this.bankName,
    required this.swiftCode,
  });

  @override
  List<Object?> get props => [
        id,
        accountNumber,
        bankName,
        swiftCode,
      ];

  String get formattedLabel => '$bankName - $accountNumber';
}
