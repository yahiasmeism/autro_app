import 'package:autro_app/core/errors/failure_mapper.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/widgets/buttons/cancel_outline_button.dart';
import 'package:autro_app/core/widgets/buttons/save_secondary_button.dart';
import 'package:autro_app/core/widgets/failure_screen.dart';
import 'package:autro_app/core/widgets/inputs/standard_input.dart';
import 'package:autro_app/core/widgets/loading_indecator.dart';
import 'package:autro_app/core/widgets/overley_loading.dart';
import 'package:autro_app/core/widgets/standard_card.dart';
import 'package:autro_app/features/settings/presentation/bloc/company/company_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/invoice_settings/invoice_settings_cubit.dart';

class InvoiceSettingsTab extends StatelessWidget {
  const InvoiceSettingsTab({super.key});

  void listener(BuildContext context, InvoiceSettingsState state) {
    if (state is InvoiceSettingsLoaded) {
      state.failureOrSuccessOption.fold(
        () => null,
        (either) => either.fold(
          (failure) => DialogUtil.showErrorSnackBar(context, getErrorMsgFromFailure(failure)),
          (message) => DialogUtil.showSuccessSnackBar(context, message),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InvoiceSettingsCubit, InvoiceSettingsState>(
      listener: listener,
      builder: (context, state) {
        if (state is InvoiceSettingsInitial) {
          return const SizedBox(
            height: 500,
            child: LoadingIndicator(),
          );
        } else if (state is InvoiceSettingsLoaded) {
          return Stack(
            children: [
              _buildInputFields(context, state),
              if (state.loading) const Positioned.fill(child: LoadingOverlay()),
            ],
          );
        } else if (state is InvoiceSettingsError) {
          return FailureScreen(
            failure: state.failure,
            onRetryTap: () => context.read<CompanyCubit>().onHandleFailure(),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildInputFields(BuildContext context, InvoiceSettingsLoaded state) {
    final cubit = context.read<InvoiceSettingsCubit>();
    return SingleChildScrollView(
      child: StandardCard(
        title: 'Invoice Settings',
        child: Form(
          key: cubit.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        StandardInput(
                          minLines: 4,
                          controller: cubit.modificationsOnBLController,
                          hintText:
                              'BL AMENDMENTS CAN BE DONE BEFORE SHIP LEAVES BCN PORT OF ORIGIN, AFTERWARDS AMENDMENTS WILL BE ON BUYER´S ACCOUNT AS SHIPPING LINE CHARGE (100 USD/AMENDMENT APROX)',
                          labelText: 'Modifications on BL',
                        ),
                        const SizedBox(height: 16),
                        StandardInput(
                          maxLines: 5,
                          controller: cubit.shippingInstructionsController,
                          labelText: 'Shipping Instructions',
                          hintText:
                              'SHIPPING INSTRUCTIONS: PROVIDED PRIOR SHIPPING INSTRUCTIONS BY BUYER. CONSIGNEE MUST BE A COMPANY OF IMPORTING COUNTRY AS ANNEX VII SHOWING THIS IS OBLIGATORY BE PROVIDED BY SELLER TO CUSTOMS IN EXPORTING COUNTRY',
                        ),
                        const SizedBox(height: 16),
                        StandardInput(
                          minLines: 2,
                          controller: cubit.specialConditionsController,
                          labelText: 'Special conditions',
                          hintText: 'LOI, AP, PSIC, IMPORT PERMISSIONS UNDER PURCHASER´S ACCOUNT',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 32),
                  Expanded(
                    child: Column(
                      children: [
                        StandardInput(
                          controller: cubit.exemptController,
                          labelText: 'Exempt',
                          hintText: 'Exempt VAT. EXPORT Section21.1 Ley 37/1992',
                        ),
                        const SizedBox(height: 16),
                        StandardInput(
                          controller: cubit.typeOfTransportController,
                          labelText: 'Type of transport',
                          hintText: '40 FT SEA CONTAINER.',
                        ),
                        const SizedBox(height: 16),
                        StandardInput(
                          controller: cubit.loadingPicturesController,
                          labelText: 'Loading Pictures',
                          hintText: 'FULL SET OF LOADING PICTURES WILL BE PROVI DED',
                        ),
                        const SizedBox(height: 16),
                        StandardInput(
                          maxLines: 2,
                          controller: cubit.loadingDateController,
                          labelText: 'Loading date',
                          hintText: 'AS SOON AS POSSIBLE, MAXIMUM 30 DAYS FROM CONTRACT SIGNING DATE',
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 32),
              _buildButtons(context, state),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context, InvoiceSettingsLoaded state) {
    return Row(
      children: [
        const Spacer(),
        if (state.dataChanged) CancelOutlineButton(onPressed: context.read<InvoiceSettingsCubit>().cancelChanges),
        const SizedBox(width: 16),
        SaveScoundaryButton(
          onPressed: state.dataChanged ? () => context.read<InvoiceSettingsCubit>().setInvoiceSettings() : null,
        ),
      ],
    );
  }
}
