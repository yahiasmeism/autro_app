import 'package:autro_app/core/extensions/list_extension.dart';
import 'package:autro_app/core/extensions/map_extension.dart';
import 'package:autro_app/core/extensions/num_extension.dart';
import 'package:autro_app/core/extensions/string_extension.dart';
import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/customers/data/models/customer_model.dart';
import 'package:autro_app/features/packing-lists/data/model/packing_list_description_model.dart';

import '../../domin/entities/packing_list_entity.dart';

class PackingListModel extends PackingListEntity implements BaseMapable {
  const PackingListModel({
    required super.details,
    required super.descriptions,
    required super.id,
    required super.dealId,
    required super.number,
    required super.customer,
    required super.taxId,
  });

  factory PackingListModel.fromJson(Map<String, dynamic> json) {
    return PackingListModel(
      customer: CustomerModel.fromJson((json['customer'] as Map<String, dynamic>?).orEmpty),
      taxId: (json['tax_id'] as String?).orEmpty,
      dealId: (json['deal_id'] as int?).toIntOrZero,
      number: (json['number'] as String?).orEmpty,
      details: (json['details'] as String?).orEmpty,
      descriptions: List<PackingListDescriptionModel>.of(
        (json['descriptions'] as List<dynamic>?).orEmpty.map((e) => PackingListDescriptionModel.fromJson(e)),
      ),
      id: (json['id'] as int?).toIntOrZero,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {};
  }
}
