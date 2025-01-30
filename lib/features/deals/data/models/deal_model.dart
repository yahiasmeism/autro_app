import 'package:autro_app/core/extensions/bool_extension.dart';
import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/extensions/map_extension.dart';
import 'package:autro_app/core/extensions/num_extension.dart';
import 'package:autro_app/core/extensions/string_extension.dart';
import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/deals/domin/entities/deal_entity.dart';
import 'package:autro_app/features/invoices/data/models/customer_invoice_model.dart';
import 'package:autro_app/features/proformas/data/models/customer_proforma_model.dart';
import 'package:autro_app/features/shipping-invoices/data/models/shipping_invoice_model.dart';

class DealModel extends DealEntity implements BaseMapable {
  const DealModel({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.notes,
    required super.isComplete,
    required super.shippingDate,
    required super.deliveryDate,
    required super.etaDate,
    required super.seriesNumber,
    required super.customerProforma,
    required super.customerInvoice,
    required super.shippingInvoice,
  });

  factory DealModel.fromJson(Map<String, dynamic> json) => DealModel(
        id: (json['id'] as int?).toIntOrZero,
        createdAt: (DateTime.tryParse((json['created_at'] as String?).orEmpty)).orDefault,
        updatedAt: (DateTime.tryParse((json['updated_at'] as String?).orEmpty)).orDefault,
        seriesNumber: (json['series_number'] as String?).orEmpty,
        deliveryDate: (DateTime.tryParse((json['delivery_date'] as String?).orEmpty)),
        customerInvoice: json['customer_invoice'] == null
            ? null
            : CustomerInvoiceModel.fromJson((json['customer_invoice'] as Map<String, dynamic>?).orEmpty),
        customerProforma: json['customer_proforma'] == null
            ? null
            : CustomerProformaModel.fromJson((json['customer_proforma'] as Map<String, dynamic>?).orEmpty),
        etaDate: (DateTime.tryParse((json['eta_date'] as String?).orEmpty)).orDefault,
        isComplete: (json['is_complete'] as bool?).orFalse,
        notes: (json['notes'] as String?).orEmpty,
        shippingDate: (DateTime.tryParse((json['shipping_date'] as String?).orEmpty)).orDefault,
        shippingInvoice: json['shipping_invoice'] == null
            ? null
            : ShippingInvoiceModel.fromJson((json['shipping_invoice'] as Map<String, dynamic>?).orEmpty),
      );

  @override
  Map<String, dynamic> toJson() {
    return {};
  }
}
