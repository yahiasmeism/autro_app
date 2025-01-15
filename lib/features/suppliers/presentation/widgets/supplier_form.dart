import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/errors/failure_mapper.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/utils/validator_util.dart';
import 'package:autro_app/core/widgets/buttons/clear_all_button.dart';
import 'package:autro_app/core/widgets/buttons/save_outline_button.dart';
import 'package:autro_app/core/widgets/inputs/country_selectable_dropdown.dart';
import 'package:autro_app/core/widgets/inputs/standard_input.dart';
import 'package:autro_app/core/widgets/inputs/standard_selectable_search.dart';
import 'package:autro_app/core/widgets/overley_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/primary_contact_type_extension.dart';
import '../../domin/entities/supplier_entity.dart';
import '../bloc/supplier_form/supplier_form_bloc.dart';

class SupplierForm extends StatefulWidget {
  const SupplierForm({super.key});
  @override
  State<SupplierForm> createState() => _SupplierFormState();
}

class _SupplierFormState extends State<SupplierForm> {
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
    return BlocConsumer<SupplierFormBloc, SupplierFormState>(
      listener: listener,
      builder: (context, state) {
        if (state is SupplierFormLoaded) {
          return Stack(
            children: [
              Form(
                key: formKey,
                child: Column(children: [
                  Row(children: [
                    Expanded(
                        child: StandardInput(
                      controller: nameController,
                      validator: ValidatorUtils.validateNameRequired,
                      labelText: 'Supplier Name',
                      showRequiredIndecator: true,
                      hintText: 'e.g John Doe',
                    )),
                    const SizedBox(width: 24),
                    Expanded(
                        child: StandardSelectableSearch(
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
                      controller: email,
                      validator: ValidatorUtils.validateEmail,
                    )),
                    const SizedBox(width: 24),
                    Expanded(
                        child: StandardInput(
                      keyboardType: TextInputType.number,
                      labelText: 'Phone Number',
                      controller: phone,
                      showRequiredIndecator: true,
                      hintText: 'e.g 1234567890',
                      validator: ValidatorUtils.validatePhoneNumber,
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
                        validator: ValidatorUtils.validateRequired,
                      )),
                    ],
                  ),
                  const SizedBox(height: 20),
                  StandardInput(
                    minLines: 3,
                    maxLines: 3,
                    labelText: 'Notes',
                    controller: notes,
                    hintText: 'e.g write anything here that you might need to store about this supplier.',
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

  _buildButtons(SupplierFormLoaded state) {
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
                  _onUpdateSupplier(state.supplier!);
                } else if (state.formType == FormType.create) {
                  _onCreateSupplier();
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

  void _onUpdateSupplier(SupplierEntity supplier) {
    final updatedSupplier = supplier.copyWith(
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

    context.read<SupplierFormBloc>().add(UpdateSupplierFormEvent(supplier: updatedSupplier));
  }

  void _onCreateSupplier() {
    context.read<SupplierFormBloc>().add(
          CreateSupplierFormEvent(
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

  void listener(BuildContext context, SupplierFormState state) {
    if (state is SupplierFormLoaded) {
      state.failureOrSuccessOption.fold(
        () => null,
        (either) => either.fold(
          (failure) => DialogUtil.showErrorSnackBar(context, getErrorMsgFromFailure(failure)),
          (message) {
            Navigator.pop(context, state.supplier);
            if (message.isNotEmpty) DialogUtil.showSuccessSnackBar(context, message);
          },
        ),
      );
      if (state.supplier != null) {
        final supplier = state.supplier!;
        nameController.text = supplier.name;
        country.text = supplier.country;
        city.text = supplier.city;
        website.text = supplier.website;
        businessDetails.text = supplier.businessDetails;
        email.text = supplier.email;
        phone.text = supplier.phone;
        altPhone.text = supplier.altPhone;
        primaryContactController.text = supplier.primaryContactType.str;
        notes.text = supplier.notes;
      }
    }
  }
}
