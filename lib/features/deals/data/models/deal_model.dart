import 'package:autro_app/core/extensions/bool_extension.dart';
import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/extensions/map_extension.dart';
import 'package:autro_app/core/extensions/num_extension.dart';
import 'package:autro_app/core/extensions/string_extension.dart';
import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/deals/domin/entities/deal_entity.dart';
import 'package:autro_app/features/invoices/data/models/invoice_model.dart';
import 'package:autro_app/features/proformas/data/models/proforma_model.dart';
import 'package:autro_app/features/shipping-invoices/data/models/shipping_invoice_model.dart';

class DealModel extends DealEntity implements BaseMapable {
  const DealModel({
    required super.id,
    required super.customerProformaId,
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
        customerProformaId: (json['customer_proforma_id']),
        createdAt: (DateTime.tryParse((json['created_at'] as String?).orEmpty)).orDefault,
        updatedAt: (DateTime.tryParse((json['updated_at'] as String?).orEmpty)).orDefault,
        seriesNumber: (json['series_number'] as String?).orEmpty,
        deliveryDate: (DateTime.tryParse((json['delivery_date'] as String?).orEmpty)),
        customerInvoice: InvoiceModel.fromJson((json['customer_invoice'] as Map<String, dynamic>?).orEmpty),
        customerProforma: ProformaModel.fromJson((json['customer_proforma'] as Map<String, dynamic>?).orEmpty),
        etaDate: (DateTime.tryParse((json['eta_date'] as String?).orEmpty)).orDefault,
        isComplete: (json['is_complete'] as bool?).orFalse,
        notes: (json['notes'] as String?).orEmpty,
        shippingDate: (DateTime.tryParse((json['shipping_date'] as String?).orEmpty)).orDefault,
        shippingInvoice: ShippingInvoiceModel.fromJson((json['shipping_invoice'] as Map<String, dynamic>?).orEmpty),
      );

  @override
  Map<String, dynamic> toJson() {
    return {};
  }
}
