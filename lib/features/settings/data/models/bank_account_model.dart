import 'package:autro_app/core/extensions/num_extension.dart';
import 'package:autro_app/core/extensions/string_extension.dart';
import 'package:autro_app/core/interfaces/mapable.dart';

import '../../domin/entities/bank_account_entity.dart';

class BankAccountModel extends BankAccountEntity implements BaseMapable {
  const BankAccountModel(
      {required super.id,
      required super.accountNumber,
      required super.bankName,
      required super.swiftCode,
      required super.currency});

  factory BankAccountModel.fromJson(Map<String, dynamic> json) => BankAccountModel(
        id: (json['id'] as int?).toIntOrZero,
        accountNumber: (json['account_number'] as String?).orEmpty,
        bankName: (json['bank_name'] as String?).orEmpty,
        swiftCode: (json['swift_code'] as String?).orEmpty,
        currency: (json['currency'] as String?).orEmpty,
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      'account_number': accountNumber,
      'bank_name': bankName,
      'swift_code': swiftCode,
      'currency': currency,
    };
  }
}
