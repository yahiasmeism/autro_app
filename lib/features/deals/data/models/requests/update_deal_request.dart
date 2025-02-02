import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/deals/domin/use_cases/update_deal_use_case.dart';

class UpdateDealRequest extends UpdateDealUseCaseParams implements RequestMapable {
  const UpdateDealRequest({
    required super.dealId,
    required super.notes,
    required super.isComplete,
    required super.shippingDate,
    required super.etaDate,
    required super.delivaryDate,
  });

  factory UpdateDealRequest.fromParams(UpdateDealUseCaseParams params) => UpdateDealRequest(
        dealId: params.dealId,
        notes: params.notes,
        isComplete: params.isComplete,
        shippingDate: params.shippingDate,
        etaDate: params.etaDate,
        delivaryDate: params.delivaryDate,
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      "is_complete": isComplete,
      if (notes != null) "notes": notes,
      if (shippingDate != null) "shipping_date": shippingDate?.formattedDateMMMDDY,
      if (etaDate != null) "eta_date": etaDate?.formattedDateMMMDDY,
      if (delivaryDate != null) "delivery_date": delivaryDate?.formattedDateMMMDDY,
    };
  }
}
