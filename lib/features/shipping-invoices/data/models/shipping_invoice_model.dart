import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/extensions/map_extension.dart';
import 'package:autro_app/core/extensions/num_extension.dart';
import 'package:autro_app/core/extensions/string_extension.dart';
import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/invoices/data/models/customer_invoice_model.dart';
import 'package:autro_app/features/shipping-invoices/domin/entities/shipping_invoice_entity.dart';

class ShippingInvoiceModel extends ShippingInvoiceEntity implements BaseMapable {
  const ShippingInvoiceModel({
    required super.id,
    required super.dealId,
    required super.shippingCompanyName,
    required super.shippingCost,
    required super.attachmentUrl,
    required super.typeMaterialName,
    required super.currency,
    required super.shippingDate,
    required super.invoice,
  });

  factory ShippingInvoiceModel.fromJson(Map<String, dynamic> json) => ShippingInvoiceModel(
        id: (json['id'] as num?).toIntOrZero,
        dealId: (json['deal_id'] as num?).toIntOrZero,
        shippingCompanyName: (json['shipping_company_name'] as String?).orEmpty,
        shippingCost: (json['shipping_cost'] as num?).toDoubleOrZero,
        attachmentUrl: (json['attachment'] as String?).orEmpty,
        typeMaterialName: (json['type_material_name'] as String?).orEmpty,
        currency: (json['currency'] as String?).orEmpty,
        shippingDate: DateTime.tryParse((json['shipping_date'] as String?).orEmpty).orDefault,
        invoice: CustomerInvoiceModel.fromJson((json['customer_invoice'] as Map<String, dynamic>?).orEmpty),
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dealId': dealId,
      'shippingCompanyName': shippingCompanyName,
      'shippingCost': shippingCost,
      'attachmentUrl': attachmentUrl,
      'typeMaterialName': typeMaterialName,
      'currency': currency,
      'shippingDate': shippingDate.formattedDateYYYYMMDD,
    };
  }
}
