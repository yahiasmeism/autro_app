import 'package:autro_app/features/customers/domin/entities/customer_entity.dart';
import 'package:autro_app/features/settings/domin/entities/bank_account_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import 'proforma_goods_description_entity.dart';

class CustomerProformaEntity extends Equatable {
  final int id;
  final String proformaNumber;
  final DateTime date;
  final String taxId;
  final String ports;
  final String deliveryTerms;
  final String paymentTerms;
  final String notes;
  final double totalPrice;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<ProformaGoodsDescriptionEntity> goodsDescriptions;
  final BankAccountEntity bankAccount;
  final CustomerEntity customer;

  const CustomerProformaEntity({
    required this.id,
    required this.proformaNumber,
    required this.date,
    required this.taxId,
    required this.ports,
    required this.deliveryTerms,
    required this.paymentTerms,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
    required this.goodsDescriptions,
    required this.bankAccount,
    required this.customer,
    required this.totalPrice,
  });

  @override
  List<Object?> get props => [
        id,
        proformaNumber,
        date,
        // customerAddress,
        taxId,
        ports,
        deliveryTerms,
        paymentTerms,
        notes,
        createdAt,
        updatedAt,
        goodsDescriptions,
        bankAccount,
        customer,
        totalPrice,
      ];

  String get formattedDate => DateFormat('MMM d, y').format(date);

  String get formattedTotalPrice => "€${totalPrice.toStringAsFixed(2)}";

  CustomerProformaEntity copyWith({
    int? id,
    String? proformaNumber,
    DateTime? date,
    // String? customerAddress,
    String? taxId,
    String? ports,
    String? deliveryTerms,
    String? paymentTerms,
    String? notes,
    double? totalPrice,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<ProformaGoodsDescriptionEntity>? goodsDescriptions,
    BankAccountEntity? bankAccount,
    CustomerEntity? customer,
  }) {
    return CustomerProformaEntity(
      id: id ?? this.id,
      proformaNumber: proformaNumber ?? this.proformaNumber,
      date: date ?? this.date,
      // customerAddress: customerAddress ?? this.customerAddress,
      taxId: taxId ?? this.taxId,
      ports: ports ?? this.ports,
      deliveryTerms: deliveryTerms ?? this.deliveryTerms,
      paymentTerms: paymentTerms ?? this.paymentTerms,
      notes: notes ?? this.notes,
      totalPrice: totalPrice ?? this.totalPrice,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      goodsDescriptions: goodsDescriptions ?? this.goodsDescriptions,
      bankAccount: bankAccount ?? this.bankAccount,
      customer: customer ?? this.customer,
    );
  }
}
