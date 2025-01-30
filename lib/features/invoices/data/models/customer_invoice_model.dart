import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/extensions/list_extension.dart';
import 'package:autro_app/core/extensions/map_extension.dart';
import 'package:autro_app/core/extensions/num_extension.dart';
import 'package:autro_app/core/extensions/string_extension.dart';
import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/customers/data/models/customer_model.dart';
import 'package:autro_app/features/invoices/data/models/invoice_goods_description_model.dart';
import 'package:autro_app/features/settings/data/models/bank_account_model.dart';

import '../../domin/entities/customer_invoice_entity.dart';

class CustomerInvoiceModel extends CustomerInvoiceEntity implements BaseMapable {
  const CustomerInvoiceModel({
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
    required super.dealId,
    required super.dealSeriesNumber,
  });

  factory CustomerInvoiceModel.fromParams(CustomerInvoiceEntity entity) {
    return CustomerInvoiceModel(
      id: entity.id,
      invoiceNumber: entity.invoiceNumber,
      date: entity.date,
      taxId: entity.taxId,
      notes: entity.notes,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      goodsDescriptions: entity.goodsDescriptions,
      bankAccount: entity.bankAccount,
      customer: entity.customer,
      totalPrice: entity.totalPrice,
      dealId: entity.dealId,
      dealSeriesNumber: entity.dealSeriesNumber,
    );
  }

  factory CustomerInvoiceModel.fromJson(Map<String, dynamic> json) {
    return CustomerInvoiceModel(
      id: (json['id'] as int?).toIntOrZero,
      invoiceNumber: (json['invoice_number'] as String?).orEmpty,
      date: DateTime.tryParse((json['date'] as String?).orEmpty).orDefault,
      taxId: (json['tax_id'] as String?).orEmpty,
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
      dealId: (json['deal_id'] as int?).toIntOrZero,
      dealSeriesNumber:
          (((json['deal'] as Map<String, dynamic>?).orEmpty).isNotEmpty ? json['deal']['series_number'] as String? : null)
              .orEmpty,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "invoice_number": invoiceNumber,
      "date": date,
      "customer_id": customer.id,
      "tax_id": taxId,
      "bank_account_id": bankAccount.id,
      "notes": notes,
      "descriptions": goodsDescriptions.map((e) => InvoiceGoodsDescriptionModel.fromParams(e).toJson()).toList(),
    };
  }
}
