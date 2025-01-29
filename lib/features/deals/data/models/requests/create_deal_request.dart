import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/deals/domin/use_cases/create_deal_use_case.dart';

class CreateDealRequest extends CreateDealUseCaseParams implements RequestMapable {
  const CreateDealRequest({required super.customerProformaId});

  @override
  Map<String, dynamic> toJson() {
    return {
      "customer_proforma_id": customerProformaId,
    };
  }
}
