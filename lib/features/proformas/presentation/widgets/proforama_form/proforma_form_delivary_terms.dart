import 'package:autro_app/core/widgets/inputs/standard_input.dart';
import 'package:autro_app/core/widgets/inputs/standard_selectable_search.dart';
import 'package:autro_app/core/widgets/standard_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/cubit/proforma_form_cubit.dart';

class ProformaFormDelivaryTerms extends StatelessWidget {
  const ProformaFormDelivaryTerms({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProformaFormCubit>();
    return StandardCard(
        title: 'Delivary Terms',
        child: Row(
          children: [
            Expanded(
              child: StandardSelectableSearch(
                items: const [
                  "LAEMCHABANG PORT - THAILAND",
                  "MERSIN PORT - TURKEY",
                  "AMBARLI PORT - TURKEY",
                  "ISKANDERUN PORT - TURKEY",
                  "ALIAGA PORT - TURKEY",
                  "GEMLIK PORT - TURKEY",
                  "TEMA PORT - GHANA",
                  "APAPA PORT - NIGERIA",
                  "KLANG WEST PORT - MALAYSIA",
                  "KLANG NORTH PORT - MALAYSIA",
                  "PENANG PORT - MALAYSIA",
                ],
                hintText: 'e.g IZMIR PORT SOCAR ALIAGA - TURKEY',
                labelText: 'Ports',
                controller: bloc.portsController,
              ),
            ),
            const SizedBox(
              width: 32,
            ),
            Expanded(
              child: StandardInput(
                labelText: 'Delivary Terms',
                controller: bloc.delivaryTermsController,
                hintText:
                    'e.g CIF (Cost, Insurance, and Freight), DTHC Not Included, 14 Free Combined Days of Detention and Demurrage',
              ),
            ),
          ],
        ));
  }
}
