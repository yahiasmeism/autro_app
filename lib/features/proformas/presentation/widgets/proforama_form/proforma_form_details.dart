import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:autro_app/core/widgets/inputs/standard_input.dart';
import 'package:autro_app/core/widgets/standard_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/customer_proforma_form_cubit/customer_proforma_form_cubit.dart';

class ProformaFormDetails extends StatelessWidget {
  const ProformaFormDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CustomerProformaFormCubit>();
    return BlocBuilder<CustomerProformaFormCubit, CustomerProformaFormState>(
      builder: (context, state) {
        final isGenerateAutoProformaNumber = state is CustomerProformaFormLoaded && state.isGenerateAutoProformaNumber;

        final updateMode = state is CustomerProformaFormLoaded && state.updatedMode;
        return StandardCard(
          title: 'Proforma Details',
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StandardInput(
                      validator: isGenerateAutoProformaNumber
                          ? null
                          : (p0) {
                              final regex = RegExp(r'.*\d+$');
                              if (!regex.hasMatch(p0 ?? '')) {
                                return 'Proforma number should contain at least one number';
                              }
                              return null;
                            },
                      key: UniqueKey(),
                      hintText: 'e.g 0142',
                      labelText: 'Proforma Number',
                      controller: isGenerateAutoProformaNumber
                          ? TextEditingController(text: 'Generate Automatically')
                          : bloc.proformaNumberController,
                      enabled: !isGenerateAutoProformaNumber && !updateMode,
                    ),
                    const SizedBox(height: 24),
                    if (!updateMode)
                      Row(
                        children: [
                          Checkbox(
                            value: isGenerateAutoProformaNumber,
                            onChanged: (_) => bloc.toggleGenerateAutoProformaNumber(),
                          ),
                          Text(
                            'Generate Auto Proforma Number',
                            style: TextStyles.font16Regular,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: StandardInput(
                  onTap: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (selectedDate != null) {
                      bloc.proformaDateController.text = selectedDate.formattedDateYYYYMMDD;
                    }
                  },
                  readOnly: true,
                  iconSuffix: const Icon(Icons.calendar_month),
                  hintText: 'e.g yyyy-mm-dd',
                  controller: bloc.proformaDateController,
                  labelText: 'Proforma Date',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
