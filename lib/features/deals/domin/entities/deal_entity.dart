import 'package:autro_app/features/customers/domin/entities/customer_entity.dart';
import 'package:autro_app/features/invoices/domin/entities/customer_invoice_entity.dart';
import 'package:autro_app/features/invoices/domin/entities/supplier_invoice_entity.dart';
import 'package:autro_app/features/proformas/domin/entities/customer_proforma_entity.dart';
import 'package:autro_app/features/proformas/domin/entities/supplier_proforma_entity.dart';
import 'package:autro_app/features/settings/domin/entities/bank_account_entity.dart';
import 'package:autro_app/features/shipping-invoices/domin/entities/shipping_invoice_entity.dart';
import 'package:autro_app/features/suppliers/domin/entities/supplier_entity.dart';
import 'package:equatable/equatable.dart';

class DealEntity extends Equatable {
  final int id;
  final String dealNumber;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String notes;
  final bool isComplete;
  final DateTime? shippingDate;
  final DateTime? deliveryDate;
  final DateTime? etaDate;
  final CustomerProformaEntity? customerProforma;
  final SupplierInvoiceEntity? supplierInvoiceEntity;
  final SupplierProformaEntity? supplierProformaEntity;
  final CustomerInvoiceEntity? customerInvoice;
  final ShippingInvoiceEntity? shippingInvoice;
  final double totalRevenue;
  final double totalExpenses;
  final double netProfit;
  final CustomerEntity? customer;
  final SupplierEntity? supplier;
  final BankAccountEntity? bankAccount;

  const DealEntity({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.notes,
    required this.isComplete,
    required this.shippingDate,
    required this.deliveryDate,
    required this.etaDate,
    required this.customerProforma,
    required this.customerInvoice,
    required this.shippingInvoice,
    required this.totalRevenue,
    required this.totalExpenses,
    required this.netProfit,
    required this.customer,
    required this.supplier,
    required this.dealNumber,
    required this.bankAccount,
    required this.supplierInvoiceEntity,
    required this.supplierProformaEntity,
  });

  String get formattedTotalRevenue => "€${totalRevenue.toStringAsFixed(2)}";
  String get formattedTotalExpenses => "€${totalExpenses.toStringAsFixed(2)}";
  String get formattedNetProfit => "€${netProfit.toStringAsFixed(2)}";

  bool get hasInvoice => customerInvoice != null;
  bool get hasShippingInvoice => shippingInvoice != null;

  @override
  List<Object?> get props => [
        id,
        createdAt,
        updatedAt,
        notes,
        isComplete,
        shippingDate,
        deliveryDate,
        etaDate,
        customerProforma,
        customerInvoice,
        shippingInvoice,
        totalRevenue,
        totalExpenses,
        netProfit,
        customer,
        supplier,
        dealNumber,
        bankAccount,
        supplierInvoiceEntity,
        supplierProformaEntity,
      ];
}
