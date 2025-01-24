import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/di/di.dart';
import 'package:autro_app/core/widgets/adaptive_layout.dart';
import 'package:autro_app/features/invoices/domin/entities/invoice_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/invoice_form/invoice_form_cubit.dart';
import 'layouts/invoice_form_desktop_layout.dart';

class InvoiceFormScreen extends StatelessWidget {
  const InvoiceFormScreen({super.key, this.invoice, required this.formType});
  final InvoiceEntity? invoice;
  final FormType formType;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<InvoiceFormCubit>()..init(invoice: invoice),
      child: AdaptiveLayout(
        mobile: (context) => const Center(
          child: Text('Invoices Mobile Layout'),
        ),
        desktop: (context) => InvoiceFormDesktopLayout(formType: formType),
      ),
    );
  }
}
