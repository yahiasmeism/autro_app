import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/settings/domin/use_cases/add_bank_account_use_case.dart';

class AddBankAccountRequest extends AddBankAccountUseCaseParams implements RequestMapable {
  const AddBankAccountRequest(
      {required super.accountNumber, required super.bankName, required super.swiftCode, required super.currency});

  factory AddBankAccountRequest.fromParams(AddBankAccountUseCaseParams params) => AddBankAccountRequest(
        accountNumber: params.accountNumber,
        bankName: params.bankName,
        swiftCode: params.swiftCode,
        currency: params.currency,
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
