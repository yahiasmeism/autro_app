import 'package:autro_app/features/customers/domin/entities/customer_entity.dart';
import 'package:autro_app/features/settings/domin/entities/bank_account_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import 'invoice_goods_description_entity.dart';

class CustomerInvoiceEntity extends Equatable {
  final int id;
  final int dealId;
  final String invoiceNumber;
  final DateTime date;
  final String taxId;
  final String notes;
  final double totalPrice;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<InvoiceGoodsDescriptionEntity> goodsDescriptions;
  final String status;
  final BankAccountEntity bankAccount;
  final CustomerEntity customer;

  const CustomerInvoiceEntity({
    required this.id,
    required this.invoiceNumber,
    required this.date,
    required this.taxId,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
    required this.goodsDescriptions,
    required this.bankAccount,
    required this.customer,
    required this.totalPrice,
    required this.dealId,
    required this.status,
  });

  @override
  List<Object?> get props => [
        id,
        invoiceNumber,
        date,
        taxId,
        notes,
        createdAt,
        updatedAt,
        goodsDescriptions,
        bankAccount,
        customer,
        totalPrice,
        dealId,
        status,
      ];

  String get formattedSeriesNumber => "Deal: ${dealId.toString().padLeft(4, '0')}";
  String get formattedDate => DateFormat('MMM d, y').format(date);

  String get formattedTotalPrice => "€${totalPrice.toStringAsFixed(2)}";

  CustomerInvoiceEntity copyWith({
    int? id,
    String? invoiceNumber,
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
    List<InvoiceGoodsDescriptionEntity>? goodsDescriptions,
    BankAccountEntity? bankAccount,
    CustomerEntity? customer,
    int? dealId,
    String? dealSeriesNumber,
    String? status,
  }) {
    return CustomerInvoiceEntity(
      id: id ?? this.id,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      date: date ?? this.date,
      taxId: taxId ?? this.taxId,
      notes: notes ?? this.notes,
      totalPrice: totalPrice ?? this.totalPrice,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      goodsDescriptions: goodsDescriptions ?? this.goodsDescriptions,
      bankAccount: bankAccount ?? this.bankAccount,
      customer: customer ?? this.customer,
      dealId: dealId ?? this.dealId,
      status: status ?? this.status,
    );
  }
}
