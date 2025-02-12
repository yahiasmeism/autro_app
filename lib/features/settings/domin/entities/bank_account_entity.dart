import 'package:equatable/equatable.dart';

class BankAccountEntity extends Equatable {
  final int id;
  final String accountNumber;
  final String bankName;
  final String swiftCode;
  final String currency;
  const BankAccountEntity({
    required this.id,
    required this.accountNumber,
    required this.bankName,
    required this.swiftCode,
    required this.currency,
  });

  @override
  List<Object?> get props => [
        id,
        accountNumber,
        bankName,
        swiftCode,
      ];

  String get formattedLabel => '$bankName - $accountNumber - $currency';
}
