import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/bills/domin/use_cases/add_bill_use_case.dart';

class AddBillRequest extends AddBillUseCaseParams implements RequestMapable {
  const AddBillRequest({
    required super.vendor,
    required super.amount,
    required super.notes,
    required super.date,
  });

  factory AddBillRequest.fromParams(AddBillUseCaseParams params) =>
      AddBillRequest(vendor: params.vendor, amount: params.amount, notes: params.notes, date: params.date);

  @override
  Map<String, dynamic> toJson() {
    return {
      'vendor': vendor,
      'amount': amount,
      'notes': notes,
      'date': date.formattedDateYYYYMMDD,
    };
  }
}
