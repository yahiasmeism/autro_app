import 'package:autro_app/core/constants/enums.dart';

extension ModuleTypeX on ModuleType {
  static ModuleType fromString(String type) {
    switch (type) {
      case 'bank_account':
        return ModuleType.bankAccount;
      case 'bill':
        return ModuleType.bill;
      case 'customer':
        return ModuleType.customer;
      case 'customer_invoice':
        return ModuleType.customerInvoice;
      case 'customer_proforma':
        return ModuleType.customerProforma;
      case 'deal':
        return ModuleType.deal;
      case 'packing_list':
        return ModuleType.packingList;
      case 'shipping_invoice':
        return ModuleType.shippingInvoice;
      case 'supplier':
        return ModuleType.supplier;
      case 'supplier_invoice':
        return ModuleType.supplierInvoice;
      case 'supplier_proforma':
        return ModuleType.supplierProforma;
      case 'user':
        return ModuleType.user;
      case 'company':
        return ModuleType.company;
      default:
        return ModuleType.unknown;
    }
  }

  String get str {
    switch (this) {
      case ModuleType.bankAccount:
        return 'bank account';
      case ModuleType.bill:
        return 'bill';
      case ModuleType.customer:
        return 'customer';
      case ModuleType.customerInvoice:
        return 'customer invoice';
      case ModuleType.customerProforma:
        return 'customer proforma';
      case ModuleType.deal:
        return 'deal';
      case ModuleType.packingList:
        return 'packing list';
      case ModuleType.shippingInvoice:
        return 'shipping invoice';
      case ModuleType.supplier:
        return 'supplier';
      case ModuleType.supplierInvoice:
        return 'supplier invoice';
      case ModuleType.supplierProforma:
        return 'supplier proforma';
      case ModuleType.user:
        return 'user';
      case ModuleType.company:
        return 'company';
      default:
        return '';
    }
  }
}



/* 
  bankAccount,
  bill,
  customer,
  customerInvoice,
  customerProforma,
  deal,
  packingList,
  shippingInvoice,
  supplier,
  supplierInvoice,
  supplierProforma,
  user,
  company,

 */