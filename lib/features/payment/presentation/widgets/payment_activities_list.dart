import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/widgets/custom_tab_bar.dart';
import 'package:autro_app/features/deals/domin/entities/deal_entity.dart';
import 'package:autro_app/features/payment/domin/entities/payment_actitvity_entity.dart';
import 'package:autro_app/features/payment/domin/entities/payment_entity.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/no_data_screen.dart';
import 'payment_history_headers_row.dart';
import 'payment_history_list_tile.dart';

class PaymentActivitiesList extends StatelessWidget {
  final DealEntity dealEntity;
  final List<PaymentEntity> payments;

  const PaymentActivitiesList({super.key, required this.dealEntity, required this.payments});

  List<PaymentActitvityEntity> get getPaymentActivities {
    final list = <PaymentActitvityEntity>[];
    for (var payment in payments) {
      list.addAll(payment.paymentActivities);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Payment History', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24)),
        Expanded(
          child: DefaultTabController(
            length: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomTabBar(
                  tabs: ['Customer', 'Supplier'],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _buildCustomerPaymentHistory(),
                      _buildSupplierPaymentHistory(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomerPaymentHistory() {
    final customerPaymentHistory = getPaymentActivities.where((element) => element.clientType == ClientType.customer).toList();
    if (customerPaymentHistory.isEmpty) {
      return const NoDataScreen(
        icon: Icons.history,
        iconSize: 60,
        text: 'No History',
      );
    }
    return Column(
      children: [
        const PaymentHistoryHeadersRow(),
        Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return const SizedBox(height: 8);
            },
            itemBuilder: (context, index) {
              return PaymentHistoryListTile(
                  currencySymbol: dealEntity.currencySymbol,
                  paymentActitvityEntity: customerPaymentHistory[index],
                  name: dealEntity.customer?.name ?? '');
            },
            itemCount: customerPaymentHistory.length,
          ),
        ),
      ],
    );
  }

  Widget _buildSupplierPaymentHistory() {
    final supplierPaymentHistory = getPaymentActivities.where((element) => element.clientType == ClientType.supplier).toList();
    if (supplierPaymentHistory.isEmpty) {
      return const NoDataScreen(
        icon: Icons.history,
        text: 'No History',
        iconSize: 60,
      );
    }
    return Column(
      children: [
        const PaymentHistoryHeadersRow(),
        Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return const SizedBox(height: 8);
            },
            itemBuilder: (context, index) {
              return PaymentHistoryListTile(
                currencySymbol: dealEntity.currencySymbol,
                paymentActitvityEntity: supplierPaymentHistory[index],
                name: dealEntity.supplier?.name ?? '',
              );
            },
            itemCount: supplierPaymentHistory.length,
          ),
        ),
      ],
    );
  }
}
