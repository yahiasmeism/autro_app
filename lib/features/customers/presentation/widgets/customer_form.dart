import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/errors/failure_mapper.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/utils/validator_util.dart';
import 'package:autro_app/core/widgets/buttons/clear_all_button.dart';
import 'package:autro_app/core/widgets/buttons/save_outline_button.dart';
import 'package:autro_app/core/widgets/inputs/country_selectable_dropdown.dart';
import 'package:autro_app/core/widgets/inputs/standard_input.dart';
import 'package:autro_app/core/widgets/inputs/standard_selectable_dropdown.dart';
import 'package:autro_app/core/widgets/overley_loading.dart';
import 'package:autro_app/features/customers/domin/entities/customer_entity.dart';
import 'package:autro_app/features/customers/presentation/bloc/customer_form/customer_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/primary_contact_type_extension.dart';

class CustomerForm extends StatefulWidget {
  const CustomerForm({super.key});
  @override
  State<CustomerForm> createState() => _CustomerFormState();
}

class _CustomerFormState extends State<CustomerForm> {
  final nameController = TextEditingController();
  final primaryContactController = TextEditingController();
  final country = TextEditingController();
  final city = TextEditingController();
  final website = TextEditingController();
  final businessDetails = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final altPhone = TextEditingController();
  final notes = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerFormBloc, CustomerFormState>(
      listener: listener,
      builder: (context, state) {
        if (state is CustomerFormLoaded) {
          return Stack(
            children: [
              Form(
                key: formKey,
                child: Column(children: [
                  Row(children: [
                    Expanded(
                        child: StandardInput(
                      controller: nameController,
                      validator: ValidatorUtil.validateNameRequired,
                      labelText: 'Customer Name',
                      showRequiredIndecator: true,
                      hintText: 'e.g John Doe',
                    )),
                    const SizedBox(width: 24),
                    Expanded(
                        child: StandardSelectableDropdownField(
                      controller: primaryContactController,
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
                      controller: country,
                    )),
                    const SizedBox(width: 24),
                    Expanded(
                        child: StandardInput(
                      controller: city,
                      labelText: 'City',
                      hintText: 'e.g SomeWhere',
                      validator: ValidatorUtil.validateNameOptional,
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
                      controller: email,
                      validator: ValidatorUtil.validateEmail,
                    )),
                    const SizedBox(width: 24),
                    Expanded(
                        child: StandardInput(
                      keyboardType: TextInputType.number,
                      labelText: 'Phone Number',
                      controller: phone,
                      showRequiredIndecator: true,
                      hintText: 'e.g 1234567890',
                      validator: ValidatorUtil.validatePhoneNumber,
                    )),
                    const SizedBox(width: 24),
                    Expanded(
                        child: StandardInput(
                      controller: altPhone,
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
                          controller: website,
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                          child: StandardInput(
                        labelText: 'Business Details',
                        showRequiredIndecator: true,
                        hintText: 'e.g Papers/Plastic/etc',
                        controller: businessDetails,
                        validator: ValidatorUtil.validateRequired,
                      )),
                    ],
                  ),
                  const SizedBox(height: 20),
                  StandardInput(
                    minLines: 3,
                    labelText: 'Notes',
                    controller: notes,
                    hintText: 'e.g write anything here that you might need to store about this customer.',
                  ),
                  const SizedBox(height: 20),
                  _buildButtons(state),
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

  _buildButtons(CustomerFormLoaded state) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ClearAllButton(
            onPressed: () {
              nameController.clear();
              primaryContactController.clear();
              country.clear();
              city.clear();
              website.clear();
              businessDetails.clear();
              email.clear();
              phone.clear();
              altPhone.clear();
              notes.clear();
            },
          ),
          const SizedBox(width: 16),
          SaveOutLineButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                if (state.formType == FormType.edit) {
                  _onUpdateCustomer(state.customer!);
                } else if (state.formType == FormType.create) {
                  _onCreateCustomer();
                }
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    primaryContactController.dispose();
    country.dispose();
    city.dispose();
    website.dispose();
    businessDetails.dispose();
    email.dispose();
    phone.dispose();
    altPhone.dispose();
    notes.dispose();
    super.dispose();
  }

  void _onUpdateCustomer(CustomerEntity customer) {
    final updatedCustomer = customer.copyWith(
      name: nameController.text,
      country: country.text,
      city: city.text,
      website: website.text,
      businessDetails: businessDetails.text,
      email: email.text,
      phone: phone.text,
      altPhone: altPhone.text,
      primaryContactType: PrimaryContactTypeX.fromString(primaryContactController.text),
      notes: notes.text,
    );

    context.read<CustomerFormBloc>().add(UpdateCustomerFormEvent(customer: updatedCustomer));
  }

  void _onCreateCustomer() {
    context.read<CustomerFormBloc>().add(
          CreateCustomerFormEvent(
            name: nameController.text,
            country: country.text,
            city: city.text,
            website: website.text,
            businessDetails: businessDetails.text,
            email: email.text,
            phone: phone.text,
            altPhone: altPhone.text,
            primaryContactType: PrimaryContactTypeX.fromString(primaryContactController.text),
            notes: notes.text,
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
            Navigator.pop(context, state.customer);
            if (message.isNotEmpty) DialogUtil.showSuccessSnackBar(context, message);
          },
        ),
      );
      if (state.customer != null) {
        final customer = state.customer!;
        nameController.text = customer.name;
        country.text = customer.country;
        city.text = customer.city;
        website.text = customer.website;
        businessDetails.text = customer.businessDetails;
        email.text = customer.email;
        phone.text = customer.phone;
        altPhone.text = customer.altPhone;
        primaryContactController.text = customer.primaryContactType.str;
        notes.text = customer.notes;
      }
    }
  }
}
