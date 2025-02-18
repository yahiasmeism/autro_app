import 'package:autro_app/core/di/di.dart';
import 'package:autro_app/core/errors/failure_mapper.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/widgets/failure_screen.dart';
import 'package:autro_app/core/widgets/loading_indecator.dart';
import 'package:autro_app/core/widgets/no_data_screen.dart';
import 'package:autro_app/core/widgets/overley_loading.dart';
import 'package:autro_app/core/widgets/standard_card.dart';
import 'package:autro_app/features/deals/domin/entities/deal_entity.dart';
import 'package:autro_app/features/payment/presentation/bloc/payments/payments_cubit.dart';
import 'package:autro_app/features/payment/presentation/widgets/customer_payment_tile.dart';
import 'package:autro_app/features/payment/presentation/widgets/payment_activities_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/supplier_payments_tile.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key, required this.deal});
  final DealEntity deal;
  void blocListener(BuildContext context, PaymentsState state) {
    if (state is PaymentsLoaded) {
      state.failureOption.fold(
        () => null,
        (failure) => DialogUtil.showErrorSnackBar(context, getErrorMsgFromFailure(failure)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = sl<PaymentsCubit>();
    return BlocProvider<PaymentsCubit>.value(
      value: cubit..getPayments(deal.id),
      child: BlocConsumer<PaymentsCubit, PaymentsState>(
        bloc: cubit,
        listener: blocListener,
        builder: (context, state) {
          if (state is PaymentsInitial) {
            return const LoadingIndicator();
          } else if (state is PaymentsLoaded) {
            if (state.payments.isEmpty) {
              return const NoDataScreen(
                icon: Icons.attach_money_outlined,
                text: 'No Payments',
              );
            }
            return _buildLoadedState(context, state);
          } else if (state is PaymentsError) {
            return FailureScreen(
              failure: state.failure,
              onRetryTap: () {
                context.read<PaymentsCubit>().getPayments(deal.id);
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildLoadedState(BuildContext context, PaymentsLoaded state) {
    return Stack(
      children: [
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _buildPayments(state),
                const SizedBox(height: 16),
                Expanded(child: PaymentActivitiesList(dealEntity: deal, payments: state.payments)),
              ],
            ),
          ),
        ),
        if (state.loading) const LoadingOverlay(),
      ],
    );
  }

  Widget _buildPayments(PaymentsLoaded state) {
    return StandardCard(
      title: null,
      child: Column(
        children: [
          if (state.customerPayments.isNotEmpty && deal.customer != null)
            CustomerPaymentTile(
              payment: state.customerPayments.first,
              dealEntity: deal,
              customerName: deal.customer!.name,
            ),
          if (state.supplierPayments.isNotEmpty && deal.supplier != null) ...[
            const SizedBox(height: 16),
            SupplierPaymentTile(
              deal: deal,
              payment: state.supplierPayments.first,
              supplierName: deal.supplier!.name,
            ),
          ],
        ],
      ),
    );
  }
}
