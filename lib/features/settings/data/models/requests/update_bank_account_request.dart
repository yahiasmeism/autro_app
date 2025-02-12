import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/settings/domin/use_cases/update_bank_account_use_case.dart';

class UpdateBankAccountRequest extends UpdateBankAccountUseCaseParams implements RequestMapable {
  const UpdateBankAccountRequest(
      {required super.accountNumber,
      required super.bankName,
      required super.swiftCode,
      required super.currency,
      required super.id});

  factory UpdateBankAccountRequest.fromParams(UpdateBankAccountUseCaseParams params) {
    return UpdateBankAccountRequest(
      accountNumber: params.accountNumber,
      bankName: params.bankName,
      swiftCode: params.swiftCode,
      currency: params.currency,
      id: params.id,
    );
  }

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
