import 'package:autro_app/core/widgets/inputs/standard_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/standard_card.dart';
import '../../bloc/customer_invoice_form/customer_invoice_form_cubit.dart';

class CustomerInvoiceFormShippingDetails extends StatelessWidget {
  const CustomerInvoiceFormShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return StandardCard(
      title: 'Shipping Details',
      child: StandardInput(
        labelText: 'Notes (optional)',
        hintText:
            'e.g INVO0149 HDPE PLASTIC SCRAP HS CODE 39151020 -CFR MERSIN PORT- TURKEY CONSIGNEE: OZ BESLENEN TARIMURUNLERI NAK. PET.TEKS. SAN VE TIC LTD STİ. AKCATAS MAH. 1CAD, NO:11-1 VIRANSEHIR/SANLIURFA)',
        minLines: 3,
        controller: context.read<CustomerInvoiceFormCubit>().notesController,
      ),
    );
  }
}
