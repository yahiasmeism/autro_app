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
import 'package:autro_app/features/customers/presentation/bloc/customer_form/customer_form_bloc.dart';
import 'package:autro_app/features/customers/presentation/bloc/customers_list/customers_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerForm extends StatelessWidget {
  const CustomerForm({super.key});
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CustomerFormBloc>();
    return BlocConsumer<CustomerFormBloc, CustomerFormState>(
      listener: listener,
      builder: (context, state) {
        if (state is CustomerFormLoaded) {
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
                      labelText: 'Customer Name',
                      showRequiredIndecator: true,
                      hintText: 'e.g John Doe',
                    )),
                    const SizedBox(width: 24),
                    Expanded(
                        child: StandardSelectableDropdown(
                      initialValue: bloc.primaryContactController.text.isNotEmpty ? bloc.primaryContactController.text : null,
                      onChanged: (p0) => bloc.primaryContactController.text = p0 ?? '',
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
                      labelText: 'Address',
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
                    hintText: 'e.g write anything here that you might need to store about this customer.',
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

  _buildButtons(BuildContext context, CustomerFormLoaded state) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (state.cancelEnabled)
            CancelOutlineButton(
              onPressed: () => context.read<CustomerFormBloc>().add(CancelCustomerFormEvent()),
            ),
          SizedBox(width: state.cancelEnabled ? 16 : 0),
          ClearAllButton(
            onPressed: state.clearEnabled ? () => context.read<CustomerFormBloc>().add(ClearCustomerFormEvent()) : null,
          ),
          const SizedBox(width: 16),
          SaveOutLineButton(
            onPressed: state.saveEnabled ? () => context.read<CustomerFormBloc>().add(SubmitCustomerFormEvent()) : null,
          ),
        ],
      ),
    );
  }

  void listener(BuildContext context, CustomerFormState state) {
    if (state is CustomerFormLoaded) {
      state.failureOrSuccessOption.fold(
        () => null,
        (either) => either.fold(
          (failure) => DialogUtil.showErrorSnackBar(context, getErrorMsgFromFailure(failure)),
          (message) {
            if (state.customer != null) {
              context.read<CustomersListBloc>().add(AddedUpdatedCustomerEvent());
            }
            NavUtil.pop(context, state.customer);
            return DialogUtil.showSuccessSnackBar(context, message);
          },
        ),
      );
    }
  }
}
