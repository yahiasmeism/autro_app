import 'package:autro_app/core/widgets/inputs/standard_selectable_search.dart';
import 'package:autro_app/core/widgets/standard_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/customer_proforma_form_cubit/customer_proforma_form_cubit.dart';

class ProformaFormPaymentTerms extends StatelessWidget {
  const ProformaFormPaymentTerms({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProformaFormCubit>();
    return StandardCard(
      title: 'Payment Terms',
      child: StandardSelectableSearch(
        items: const [
          '30% CASH IN ADVANCE 70% CASH AGAINST DOCUMENTS',
          '20% CASH IN ADVANCE 80% CASH AGAINST DOCUMENTS',
          '100% CASH IN ADVANCE',
        ],
        labelText: 'Payment Terms',
        controller: bloc.paymentTermsController,
        hintText: 'e.g 30% CIA – 70% 14 days before ETA and after receiving copy of all documents required',
      ),
    );
  }
}
