import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/widgets/failure_screen.dart';
import 'package:autro_app/core/widgets/loading_indecator.dart';
import 'package:autro_app/core/widgets/standard_card.dart';
import 'package:autro_app/features/shipping-invoices/presentation/bloc/shipping_invoice_form/shipping_invoice_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/shipping_invoice_form.dart';

class ShippingInvoiceFormDesktopLayout extends StatelessWidget {
  const ShippingInvoiceFormDesktopLayout({super.key, required this.formType});
  final FormType formType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocBuilder<ShippingInvoiceFormBloc, ShippingInvoiceFormState>(
        builder: (context, state) {
          if (state is ShippingInvoiceInfoInitial) {
            return const LoadingIndicator();
          } else if (state is ShippingInvoiceFormLoaded) {
            return const SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: StandardCard(
                  title: 'Shipping Invoice Information',
                  child: ShippingInvoiceForm(),
                ),
              ),
            );
          } else if (state is ShippingInvoiceFormError) {
            return FailureScreen(
              failure: state.failure,
              onRetryTap: () {
                context.read<ShippingInvoiceFormBloc>().add(ShippingInvoiceFormHandleFailure());
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
        return 'Edit Shipping Invoice';
      case FormType.create:
        return 'Add New Shipping Invoice';
      default:
        return 'Shipping Invoice';
    }
  }
}
