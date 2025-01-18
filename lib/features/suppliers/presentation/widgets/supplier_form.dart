import 'package:autro_app/core/errors/failure_mapper.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/utils/nav_util.dart';
import 'package:autro_app/core/utils/validator_util.dart';
import 'package:autro_app/core/widgets/buttons/cancel_outline_button.dart';
import 'package:autro_app/core/widgets/buttons/clear_all_button.dart';
import 'package:autro_app/core/widgets/buttons/save_outline_button.dart';
import 'package:autro_app/core/widgets/inputs/country_selectable_dropdown.dart';
import 'package:autro_app/core/widgets/inputs/standard_input.dart';
import 'package:autro_app/core/widgets/overley_loading.dart';
import 'package:autro_app/core/widgets/standard_selection_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/supplier_form/supplier_form_bloc.dart';

class SupplierForm extends StatelessWidget {
  const SupplierForm({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SupplierFormBloc, SupplierFormState>(
      listener: listener,
      builder: (context, state) {
        if (state is SupplierFormLoaded) {
          final bloc = context.read<SupplierFormBloc>();
          return Stack(
            children: [
              Form(
                key: bloc.formKey,
                child: Column(children: [
                  Row(children: [
                    Expanded(
                        child: StandardInput(
                      controller: bloc.nameController,
                      validator: ValidatorUtils.validateNameRequired,
                      labelText: 'Supplier Name',
                      showRequiredIndecator: true,
                      hintText: 'e.g John Doe',
                    )),
                    const SizedBox(width: 24),
                    Expanded(
                        child: StandardSelectableDropdown(
                      initialValue: bloc.primaryContactController.text.isNotEmpty ? bloc.primaryContactController.text : null,
                      onChanged: (p0) {
                        bloc.primaryContactController.text = p0 ?? '';
                      },
                      items: const [
                        'Email',
                        'Phone',
                      ],
                      showRequiredIndicator: true,
                      labelText: 'Primary Contact',
                      hintText: 'Email/Phone',
                    )),
                  ]),
                  const SizedBox(height: 20),
                  Row(children: [
                    Expanded(
                        child: CountrySelectableDropdown(
                      controller: bloc.country,
                    )),
                    const SizedBox(width: 24),
                    Expanded(
                        child: StandardInput(
                      controller: bloc.city,
                      labelText: 'City',
                      hintText: 'e.g SomeWhere',
                      validator: ValidatorUtils.validateNameOptional,
                    )),
                  ]),
                  const SizedBox(height: 20),
                  Row(children: [
                    Expanded(
                        child: StandardInput(
                      labelText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      showRequiredIndecator: true,
                      hintText: 'e.g 8PqHj@example.com',
                      controller: bloc.email,
                      validator: ValidatorUtils.validateEmail,
                    )),
                    const SizedBox(width: 24),
                    Expanded(
                        child: StandardInput(
                      keyboardType: TextInputType.number,
                      labelText: 'Phone Number',
                      controller: bloc.phone,
                      showRequiredIndecator: true,
                      hintText: 'e.g 1234567890',
                      validator: ValidatorUtils.validatePhoneNumber,
                    )),
                    const SizedBox(width: 24),
                    Expanded(
                        child: StandardInput(
                      controller: bloc.altPhone,
                      labelText: 'Alternative Phone Number',
                      hintText: 'e.g SomeWhere',
                    )),
                  ]),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: StandardInput(
                          labelText: 'Website',
                          hintText: 'e.g Something.com',
                          controller: bloc.website,
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                          child: StandardInput(
                        labelText: 'Business Details',
                        showRequiredIndecator: true,
                        hintText: 'e.g Papers/Plastic/etc',
                        controller: bloc.businessDetails,
                        validator: ValidatorUtils.validateRequired,
                      )),
                    ],
                  ),
                  const SizedBox(height: 20),
                  StandardInput(
                    minLines: 3,
                    maxLines: 3,
                    labelText: 'Notes',
                    controller: bloc.notes,
                    hintText: 'e.g write anything here that you might need to store about this supplier.',
                  ),
                  const SizedBox(height: 20),
                  _buildButtons(context, state),
                ]),
              ),
              if (state.loading) const Positioned.fill(child: LoadingOverlay()),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  _buildButtons(BuildContext context, SupplierFormLoaded state) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (state.cancelEnabled)
            CancelOutlineButton(onPressed: () => context.read<SupplierFormBloc>().add(CancelSupplierFormEvent())),
          const SizedBox(width: 16),
          ClearAllButton(
            onPressed: state.clearEnabled ? () => context.read<SupplierFormBloc>().add(ClearSupplierFormEvent()) : null,
          ),
          const SizedBox(width: 16),
          SaveOutLineButton(
            onPressed: state.saveEnabled ? () => context.read<SupplierFormBloc>().add(SubmitSupplierFormEvent()) : null,
          ),
        ],
      ),
    );
  }

  void listener(BuildContext context, SupplierFormState state) {
    if (state is SupplierFormLoaded) {
      state.failureOrSuccessOption.fold(
        () => null,
        (either) => either.fold(
          (failure) => DialogUtil.showErrorSnackBar(context, getErrorMsgFromFailure(failure)),
          (message) {
            if (!state.updatedMode) NavUtil.pop(context);
            DialogUtil.showSuccessSnackBar(context, message);
          },
        ),
      );
    }
  }
}
