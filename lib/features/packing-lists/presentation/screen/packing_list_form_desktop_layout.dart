import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/errors/failure_mapper.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/utils/nav_util.dart';
import 'package:autro_app/core/widgets/failure_screen.dart';
import 'package:autro_app/core/widgets/loading_indecator.dart';
import 'package:autro_app/core/widgets/overley_loading.dart';
import 'package:autro_app/features/deals/presentation/bloc/deals_list/deals_list_bloc.dart';
import 'package:autro_app/features/packing-lists/presentation/bloc/packing_lists/packing_lists_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../deals/presentation/bloc/deal_details/deal_details_cubit.dart';
import '../bloc/packing_list_form/packing_list_form_cubit.dart';
import '../widgets/packing_list_form.dart';

class PackingListFormDesktopLayout extends StatelessWidget {
  const PackingListFormDesktopLayout({super.key, required this.formType});
  final FormType formType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocConsumer<PackingListFormCubit, PackingListFormState>(
        listener: (context, state) {
          if (state is PackingListFormLoaded) {
            state.failureOrSuccessOption.fold(
              () => null,
              (either) {
                either.fold(
                  (failure) => DialogUtil.showErrorSnackBar(context, getErrorMsgFromFailure(failure)),
                  (message) {
                    if (state.packingList != null) {
                      context.read<PackingListsBloc>().add(AddedUpdatedPackingListEvent());
                      context.read<DealsListBloc>().add(const GetDealsListEvent());
                      context.read<DealDetailsCubit>().refresh();
                    }
                    NavUtil.pop(context, state.packingList);
                    return DialogUtil.showSuccessSnackBar(context, message);
                  },
                );
              },
            );
          }
        },
        builder: (context, state) {
          if (state is PackingListFormInitial) {
            return const LoadingIndicator();
          } else if (state is PackingListFormLoaded) {
            return Stack(
              children: [
                const Positioned.fill(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: PackingListForm(),
                    ),
                  ),
                ),
                if (state.loading) const LoadingOverlay(),
              ],
            );
          } else if (state is PackingListFormError) {
            return FailureScreen(
              failure: state.failure,
              onRetryTap: () {
                context.read<PackingListFormCubit>().handleFailure();
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
        return 'Edit Packing List';
      case FormType.create:
        return 'Add New Packing List';
      default:
        return 'Packing List';
    }
  }
}
