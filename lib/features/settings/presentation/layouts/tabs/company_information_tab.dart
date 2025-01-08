import 'package:autro_app/core/widgets/buttons/clear_all_button.dart';
import 'package:autro_app/core/widgets/buttons/save_secondary_button.dart';
import 'package:autro_app/core/widgets/inputs/standard_input.dart';
import 'package:autro_app/core/widgets/standard_card.dart';
import 'package:autro_app/features/settings/widgets/company_logo_uploader.dart';
import 'package:flutter/material.dart';

import '../../../widgets/company_signature_uploader.dart';

class CompanyInformationTab extends StatelessWidget {
  const CompanyInformationTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StandardCard(
        title: 'Company Information',
        child: _buildInputFields(),
      ),
    );
  }

  Widget _buildInputFields() {
    return Column(
      children: [
        const Row(
          children: [
            Expanded(
                child: StandardInput(
              hintText: 'enter company name',
              labelText: 'Company Name',
            )),
            SizedBox(width: 28),
            Expanded(
                child: StandardInput(
              labelText: 'Company Address',
              hintText: 'enter company address',
            )),
          ],
        ),
        const SizedBox(height: 16),
        const Row(
          children: [
            Expanded(
                child: StandardInput(
              labelText: 'Phone Number',
              hintText: 'enter phone number',
            )),
            SizedBox(width: 28),
            Expanded(
                child: StandardInput(
              labelText: 'Email Address',
              hintText: 'enter email address',
            )),
          ],
        ),
        const SizedBox(height: 16),
        const Row(
          children: [
            Expanded(
                child: StandardInput(
              labelText: 'Telephone Number',
              hintText: 'enter telephone number',
            )),
            SizedBox(width: 28),
            Expanded(
              child: StandardInput(
                labelText: 'Website URL',
                hintText: 'enter website url',
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
        _buildButtons(),
      ],
    );
  }

  Widget _buildButtons() {
    return Row(
      children: [
        const Spacer(),
        ClearAllButton(
          onPressed: () {},
        ),
        const SizedBox(width: 16),
        SaveScoundaryButton(
          onPressed: () {},
        ),
      ],
    );
  }
}
