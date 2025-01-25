import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/extensions/num_extension.dart';
import 'package:autro_app/core/extensions/string_extension.dart';
import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/shipping-invoices/domin/entities/shipping_invoice_entites.dart';

class ShippingInvoiceModel extends ShippingInvoiceEntity implements BaseMapable {
  const ShippingInvoiceModel({
    required super.id,
    required super.invoiceId,
    required super.shippingCompanyName,
    required super.shippingCost,
    required super.attachmentPath,
    required super.typeMaterialName,
    required super.currency,
    required super.shippingDate,
  });

  factory ShippingInvoiceModel.fromJson(Map<String, dynamic> json) => ShippingInvoiceModel(
        id: (json['id'] as num?).toIntOrZero,
        invoiceId: (json['invoiceId'] as num?).toIntOrZero,
        shippingCompanyName: (json['shippingCompanyName'] as String?).orEmpty,
        shippingCost: (json['shippingCost'] as num?).toDoubleOrZero,
        attachmentPath: (json['attachmentPath'] as String?).orEmpty,
        typeMaterialName: (json['typeMaterialName'] as String?).orEmpty,
        currency: (json['currency'] as String?).orEmpty,
        shippingDate: DateTime.tryParse((json['shippingDate'] as String?).orEmpty).orDefault,
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'invoiceId': invoiceId,
      'shippingCompanyName': shippingCompanyName,
      'shippingCost': shippingCost,
      'attachmentPath': attachmentPath,
      'typeMaterialName': typeMaterialName,
      'currency': currency,
      'shippingDate': shippingDate.formattedDateYYYYMMDD,
    };
  }
}
