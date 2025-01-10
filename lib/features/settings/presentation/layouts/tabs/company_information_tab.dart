import 'package:autro_app/core/errors/failure_mapper.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/utils/validator_util.dart';
import 'package:autro_app/core/widgets/buttons/save_secondary_button.dart';
import 'package:autro_app/core/widgets/failure_screen.dart';
import 'package:autro_app/core/widgets/inputs/standard_input.dart';
import 'package:autro_app/core/widgets/loading_overlay.dart';
import 'package:autro_app/core/widgets/standard_card.dart';
import 'package:autro_app/features/settings/presentation/bloc/company/company_cubit.dart';
import 'package:autro_app/features/settings/presentation/widgets/company_logo_uploader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/company_signature_uploader.dart';

class CompanyInformationTab extends StatelessWidget {
  const CompanyInformationTab({super.key});

  void listener(BuildContext context, CompanyState state) {
    if (state is CompanyLoaded) {
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
    return BlocConsumer<CompanyCubit, CompanyState>(
      listener: listener,
      builder: (context, state) {
        if (state is CompanyInitial) {
          return const SizedBox(
            height: 500,
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state is CompanyLoaded) {
          return Stack(
            children: [
              _buildInputFields(context, state),
              if (state.loading) const Positioned.fill(child: LoadingOverlay()),
            ],
          );
        } else if (state is CompanyError) {
          return FailureScreen(
            failure: state.failure,
            onRetryTap: () => context.read<CompanyCubit>().onHandleFailure(),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildInputFields(BuildContext context, CompanyLoaded state) {
    final cubit = context.read<CompanyCubit>();

    return SingleChildScrollView(
      child: StandardCard(
        title: 'Company Information',
        child: Form(
          key: cubit.formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: StandardInput(
                      controller: cubit.companyNameController,
                      hintText: 'Enter company name',
                      labelText: 'Company Name',
                      validator: (value) => ValidatorUtils.validateRequiredField(value, 'Company Name'),
                    ),
                  ),
                  const SizedBox(width: 28),
                  Expanded(
                    child: StandardInput(
                      controller: cubit.companyAddressController,
                      labelText: 'Company Address',
                      hintText: 'Enter company address',
                      validator: (value) => ValidatorUtils.validateRequiredField(value, 'Company Address'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: StandardInput(
                      controller: cubit.companyPhoneController,
                      labelText: 'Phone Number',
                      hintText: 'Enter phone number',
                      validator: ValidatorUtils.validatePhoneNumber,
                    ),
                  ),
                  const SizedBox(width: 28),
                  Expanded(
                    child: StandardInput(
                      controller: cubit.companyEmailController,
                      labelText: 'Email Address',
                      hintText: 'Enter email address',
                      validator: ValidatorUtils.validateEmail,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: StandardInput(
                      controller: cubit.companyTelephoneController,
                      labelText: 'Telephone Number',
                      hintText: 'Enter telephone number',
                      validator: ValidatorUtils.validatePhoneNumber,
                    ),
                  ),
                  const SizedBox(width: 28),
                  Expanded(
                    child: StandardInput(
                      controller: cubit.companyWebsiteController,
                      labelText: 'Website URL',
                      hintText: 'Enter website URL',
                      validator: ValidatorUtils.validateWebsite,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Row(
                children: [
                  Expanded(child: CompanyLogoUploader()),
                  SizedBox(width: 28),
                  Expanded(child: CompanySignatureUploader()),
                ],
              ),
              const SizedBox(height: 48),
              _buildButtons(context, state),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context, CompanyLoaded state) {
    return Row(
      children: [
        const Spacer(),
        const SizedBox(width: 16),
        SaveScoundaryButton(
          onPressed: state.saveEnabled ? () => context.read<CompanyCubit>().changeCompanyInfo() : null,
        ),
      ],
    );
  }
}
