import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/errors/failure_mapper.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/utils/nav_util.dart';
import 'package:autro_app/core/widgets/failure_screen.dart';
import 'package:autro_app/core/widgets/loading_indecator.dart';
import 'package:autro_app/core/widgets/overley_loading.dart';
import 'package:autro_app/features/proformas/presentation/bloc/customer_proforma_form_cubit/customer_proforma_form_cubit.dart';
import 'package:autro_app/features/proformas/presentation/bloc/customers_proformas_list/customers_proformas_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../deals/presentation/bloc/deal_details/deal_details_cubit.dart';
import '../../../../../deals/presentation/bloc/deals_list/deals_list_bloc.dart';
import '../../../widgets/proforama_form/proforma_form.dart';

class CustomerProformaFormDesktopLayout extends StatelessWidget {
  const CustomerProformaFormDesktopLayout({super.key, required this.formType});
  final FormType formType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocConsumer<CustomerProformaFormCubit, CustomerProformaFormState>(
        listener: (context, state) {
          if (state is CustomerProformaFormLoaded) {
            state.failureOrSuccessOption.fold(
              () => null,
              (either) {
                either.fold(
                  (failure) => DialogUtil.showErrorSnackBar(context, getErrorMsgFromFailure(failure)),
                  (message) {
                    if (state.proforma != null) {
                      context.read<CustomersProformasListBloc>().add(AddedUpdatedProformaEvent());
                      context.read<DealsListBloc>().add(GetDealsListEvent());
                      context.read<DealDetailsCubit>().refresh();
                    }
                    NavUtil.pop(context, state.proforma);
                    return DialogUtil.showSuccessSnackBar(context, message);
                  },
                );
              },
            );
          }
        },
        builder: (context, state) {
          if (state is CustomerProformaFormInitial) {
            return const LoadingIndicator();
          } else if (state is CustomerProformaFormLoaded) {
            return Stack(
              children: [
                Positioned.fill(
                  child: SingleChildScrollView(
                    controller: context.read<CustomerProformaFormCubit>().scrollController,
                    child: const Padding(
                      padding: EdgeInsets.all(24),
                      child: ProformaForm(),
                    ),
                  ),
                ),
                if (state.loading) const LoadingOverlay(),
              ],
            );
          } else if (state is CustomerProformaFormError) {
            return FailureScreen(
              failure: state.failure,
              onRetryTap: () {
                context.read<CustomerProformaFormCubit>().handleError();
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  String get title {
    switch (formType) {
      case FormType.edit:
        return 'Edit Proforma';
      case FormType.create:
        return 'Add New Proforma';
      default:
        return 'Proforma';
    }
  }
}
