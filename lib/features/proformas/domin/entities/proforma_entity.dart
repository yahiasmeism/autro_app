import 'package:autro_app/features/customers/domin/entities/customer_entity.dart';
import 'package:autro_app/features/settings/domin/entities/bank_account_entity.dart';
import 'package:equatable/equatable.dart';

import 'proforma_goods_description_entity.dart';

class ProformaEntity extends Equatable {
  final int id;
  final String proformaNumber;
  final DateTime date;
  final String address;
  final String taxId;
  final String ports;
  final String deliveryTerms;
  final String paymentTerms;
  final String notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<ProformaGoodsDescriptionEntity> goodsDescriptions;
  final BankAccountEntity bankAccount;
  final CustomerEntity customer;

  const ProformaEntity({
    required this.id,
    required this.proformaNumber,
    required this.date,
    required this.address,
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
  });

  @override
  List<Object?> get props => [
        id,
        proformaNumber,
        date,
        address,
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
      ];
}
