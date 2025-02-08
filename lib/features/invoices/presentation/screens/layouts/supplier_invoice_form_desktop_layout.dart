import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/widgets/failure_screen.dart';
import 'package:autro_app/core/widgets/loading_indecator.dart';
import 'package:autro_app/core/widgets/standard_card.dart';
import 'package:autro_app/features/invoices/presentation/bloc/supplier_invoice_form/supplier_invoice_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/supplier_invoice_form/supplier_invoice_form.dart';

class SupplierInvoiceFormDesktopLayout extends StatelessWidget {
  const SupplierInvoiceFormDesktopLayout({super.key, required this.formType});
  final FormType formType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocBuilder<SupplierInvoiceFormBloc, SupplierInvoiceFormState>(
        builder: (context, state) {
          if (state is SupplierInvoiceInfoInitial) {
            return const LoadingIndicator();
          } else if (state is SupplierInvoiceFormLoaded) {
            return const SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: StandardCard(
                  title: 'Supplier Invoice Information',
                  child: SupplierInvoiceForm(),
                ),
              ),
            );
          } else if (state is SupplierInvoiceFormError) {
            return FailureScreen(
              failure: state.failure,
              onRetryTap: () {
                context.read<SupplierInvoiceFormBloc>().add(SupplierInvoiceHandleError());
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  String get title {
    switch (formType) {
      case FormType.edit:
        return 'Edit Supplier Invoice';
      case FormType.create:
        return 'Add New Supplier Invoice';
      default:
        return 'Supplier Invoice';
    }
  }
}
