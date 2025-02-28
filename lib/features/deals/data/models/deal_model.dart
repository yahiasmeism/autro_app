import 'package:autro_app/core/extensions/bool_extension.dart';
import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/extensions/list_extension.dart';
import 'package:autro_app/core/extensions/map_extension.dart';
import 'package:autro_app/core/extensions/num_extension.dart';
import 'package:autro_app/core/extensions/string_extension.dart';
import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/deals/domin/entities/deal_entity.dart';
import 'package:autro_app/features/invoices/data/models/customer_invoice_model.dart';
import 'package:autro_app/features/invoices/data/models/supplier_invoice_model.dart';
import 'package:autro_app/features/payment/data/models/payment_model.dart';
import 'package:autro_app/features/proformas/data/models/customer_proforma_model.dart';
import 'package:autro_app/features/proformas/data/models/supplier_proforma_model.dart';
import 'package:autro_app/features/shipping-invoices/data/models/shipping_invoice_model.dart';
import 'package:autro_app/features/suppliers/data/models/supplier_model.dart';

import '../../../customers/data/models/customer_model.dart';
import '../../../settings/data/models/bank_account_model.dart';

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
    required super.customerProforma,
    required super.customerInvoice,
    required super.shippingInvoice,
    required super.totalRevenue,
    required super.totalExpenses,
    required super.netProfit,
    required super.dealNumber,
    required super.suppliers,
    required super.customer,
    required super.bankAccount,
    required super.supplierInvoices,
    required super.supplierProformaEntity,
    required super.payments,
  });

  factory DealModel.fromJson(Map<String, dynamic> json) => DealModel(
        id: (json['id'] as int?).toIntOrZero,
        createdAt: (DateTime.tryParse((json['created_at'] as String?).orEmpty)).orDefault,
        updatedAt: (DateTime.tryParse((json['updated_at'] as String?).orEmpty)).orDefault,
        deliveryDate: (DateTime.tryParse((json['delivery_date'] as String?).orEmpty)),
        customerInvoice: json['customer_invoice'] == null
            ? null
            : CustomerInvoiceModel.fromJson((json['customer_invoice'] as Map<String, dynamic>?).orEmpty),
        customerProforma: json['customer_proforma'] == null
            ? null
            : CustomerProformaModel.fromJson((json['customer_proforma'] as Map<String, dynamic>?).orEmpty),
        etaDate: (DateTime.tryParse((json['eta_date'] as String?).orEmpty)),
        isComplete: (json['is_complete'] as bool?).orFalse,
        notes: (json['notes'] as String?).orEmpty,
        shippingDate: (DateTime.tryParse((json['shipping_date'] as String?).orEmpty)),
        shippingInvoice: json['shipping_invoice'] == null
            ? null
            : ShippingInvoiceModel.fromJson((json['shipping_invoice'] as Map<String, dynamic>?).orEmpty),
        totalExpenses: (json['total_expenses'] as num?).toDoubleOrZero,
        totalRevenue: (json['total_revenue'] as num?).toDoubleOrZero,
        netProfit: (json['net_profit'] as num?).toDoubleOrZero,
        dealNumber: (json['deal_number'] as String?).orEmpty,
        suppliers: List<SupplierModel>.from(
          (json['suppliers'] as List?)?.map((e) => SupplierModel.fromJson((e as Map<String, dynamic>?).orEmpty)) ?? [],
        ),
        customer: json['customer'] == null ? null : CustomerModel.fromJson((json['customer'] as Map<String, dynamic>?).orEmpty),
        bankAccount: json['bank_account'] == null
            ? null
            : BankAccountModel.fromJson((json['bank_account'] as Map<String, dynamic>?).orEmpty),
        supplierProformaEntity: json['supplier_proforma'] == null
            ? null
            : SupplierProformaModel.fromJson(json['supplier_proforma'] as Map<String, dynamic>),
        payments: (json['payments'] as List?).orEmpty.map((e) => PaymentModel.fromJson(e as Map<String, dynamic>)).toList(),
        supplierInvoices: (json['supplier_invoices'] as List?)
            .orEmpty
            .map((e) => SupplierInvoiceModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  @override
  Map<String, dynamic> toJson() {
    return {};
  }
}
