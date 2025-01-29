import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/extensions/list_extension.dart';
import 'package:autro_app/core/extensions/map_extension.dart';
import 'package:autro_app/core/extensions/num_extension.dart';
import 'package:autro_app/core/extensions/string_extension.dart';
import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/customers/data/models/customer_model.dart';
import 'package:autro_app/features/invoices/data/models/invoice_goods_description_model.dart';
import 'package:autro_app/features/settings/data/models/bank_account_model.dart';

import '../../../proformas/data/models/customer_proforma_model.dart';
import '../../domin/entities/invoice_entity.dart';

class InvoiceModel extends InvoiceEntity implements BaseMapable {
  const InvoiceModel({
    required super.proforma,
    required super.id,
    required super.invoiceNumber,
    required super.date,
    required super.taxId,
    required super.notes,
    required super.createdAt,
    required super.updatedAt,
    required super.goodsDescriptions,
    required super.bankAccount,
    required super.customer,
    required super.totalPrice,
  });

  factory InvoiceModel.fromParams(InvoiceEntity entity) {
    return InvoiceModel(
      id: entity.id,
      invoiceNumber: entity.invoiceNumber,
      date: entity.date,
      // customerAddress: entity.customerAddress,
      taxId: entity.taxId,
      proforma: entity.proforma,
      notes: entity.notes,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      goodsDescriptions: entity.goodsDescriptions,
      bankAccount: entity.bankAccount,
      customer: entity.customer,
      totalPrice: entity.totalPrice,
    );
  }

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      id: (json['id'] as int?).toIntOrZero,
      invoiceNumber: (json['invoice_number'] as String?).orEmpty,
      date: DateTime.tryParse((json['date'] as String?).orEmpty).orDefault,
      taxId: (json['tax_id'] as String?).orEmpty,
      proforma: CustomerProformaModel.fromJson((json['proforma'] as Map<String, dynamic>?).orEmpty),
      notes: (json['notes'] as String?).orEmpty,
      createdAt: DateTime.tryParse((json['created_at'] as String?).orEmpty).orDefault,
      updatedAt: DateTime.tryParse((json['updated_at'] as String?).orEmpty).orDefault,
      goodsDescriptions: List<InvoiceGoodsDescriptionModel>.of(
        (json['goods_descriptions'] as List<dynamic>?)
            .orEmpty
            .map((e) => InvoiceGoodsDescriptionModel.fromJson((e as Map<String, dynamic>?).orEmpty)),
      ),
      bankAccount: BankAccountModel.fromJson((json['bank_account'] as Map<String, dynamic>?).orEmpty),
      customer: CustomerModel.fromJson((json['customer'] as Map<String, dynamic>?).orEmpty),
      totalPrice: (json['total_price'] as num?).toDoubleOrZero,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "invoice_number": invoiceNumber,
      "date": date,
      "customer_id": customer.id,
      "proforma_id": proforma.id,
      "tax_id": taxId,
      "bank_account_id": bankAccount.id,
      "notes": notes,
      "descriptions": goodsDescriptions.map((e) => InvoiceGoodsDescriptionModel.fromParams(e).toJson()).toList(),
    };
  }
}
