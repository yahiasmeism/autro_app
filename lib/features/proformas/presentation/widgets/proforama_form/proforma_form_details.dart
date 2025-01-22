import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/widgets/inputs/standard_input.dart';
import 'package:autro_app/core/widgets/standard_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/cubit/proforma_form_cubit.dart';

class ProformaFormDetails extends StatelessWidget {
  const ProformaFormDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProformaFormCubit>();
    return StandardCard(
      title: 'Proforma Details',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: StandardInput(
              hintText: 'e.g 0142',
              labelText: 'Proforma Number',
              controller: bloc.proformaNumberController,
            ),
          ),
          const SizedBox(width: 32),
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
  }
}
