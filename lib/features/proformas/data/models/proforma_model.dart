import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/extensions/list_extension.dart';
import 'package:autro_app/core/extensions/map_extension.dart';
import 'package:autro_app/core/extensions/num_extension.dart';
import 'package:autro_app/core/extensions/string_extension.dart';
import 'package:autro_app/core/interfaces/mapable.dart';
import 'package:autro_app/features/customers/data/models/customer_model.dart';
import 'package:autro_app/features/proformas/data/models/proforma_goods_description_model.dart';
import 'package:autro_app/features/settings/data/models/bank_account_model.dart';

import '../../domin/entities/proforma_entity.dart';

class ProformaModel extends ProformaEntity implements BaseMapable {
  const ProformaModel({
    required super.id,
    required super.proformaNumber,
    required super.date,
    required super.customerAddress,
    required super.taxId,
    required super.ports,
    required super.deliveryTerms,
    required super.paymentTerms,
    required super.notes,
    required super.createdAt,
    required super.updatedAt,
    required super.goodsDescriptions,
    required super.bankAccount,
    required super.customer,
    required super.totalPrice,
  });

  factory ProformaModel.fromParams(ProformaEntity entity) {
    return ProformaModel(
      id: entity.id,
      proformaNumber: entity.proformaNumber,
      date: entity.date,
      customerAddress: entity.customerAddress,
      taxId: entity.taxId,
      ports: entity.ports,
      deliveryTerms: entity.deliveryTerms,
      paymentTerms: entity.paymentTerms,
      notes: entity.notes,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      goodsDescriptions: entity.goodsDescriptions,
      bankAccount: entity.bankAccount,
      customer: entity.customer,
      totalPrice: entity.totalPrice,
    );
  }

  factory ProformaModel.fromJson(Map<String, dynamic> json) {
    return ProformaModel(
      id: (json['id'] as int?).toIntOrZero,
      proformaNumber: (json['proforma_number'] as String?).orEmpty,
      date: DateTime.tryParse((json['date'] as String?).orEmpty).orDefault,
      customerAddress: (json['customer_address'] as String?).orEmpty,
      taxId: (json['tax_id'] as String?).orEmpty,
      ports: (json['ports'] as String?).orEmpty,
      deliveryTerms: (json['delivery_terms'] as String?).orEmpty,
      paymentTerms: (json['payment_terms'] as String?).orEmpty,
      notes: (json['notes'] as String?).orEmpty,
      createdAt: DateTime.tryParse((json['created_at'] as String?).orEmpty).orDefault,
      updatedAt: DateTime.tryParse((json['updated_at'] as String?).orEmpty).orDefault,
      goodsDescriptions: List<ProformaGoodsDescriptionModel>.of(
        (json['goods_descriptions'] as List<dynamic>?)
            .orEmpty
            .map((e) => ProformaGoodsDescriptionModel.fromJson((e as Map<String, dynamic>?).orEmpty)),
      ),
      bankAccount: BankAccountModel.fromJson((json['bank_account'] as Map<String, dynamic>?).orEmpty),
      customer: CustomerModel.fromJson((json['customer'] as Map<String, dynamic>?).orEmpty),
      totalPrice: (json['total_price'] as num?).toDoubleOrZero,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "proforma_number": proformaNumber,
      "date": date,
      "customer_id": customer.id,
      "address": customerAddress,
      "tax_id": taxId,
      "ports": ports,
      "delivery_terms": deliveryTerms,
      "payment_terms": paymentTerms,
      "bank_account_id": bankAccount.id,
      "notes": notes,
      "descriptions": goodsDescriptions.map((e) => ProformaGoodsDescriptionModel.fromParams(e).toJson()).toList(),
    };
  }
}
