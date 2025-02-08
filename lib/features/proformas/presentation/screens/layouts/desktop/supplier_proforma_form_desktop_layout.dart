import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/widgets/failure_screen.dart';
import 'package:autro_app/core/widgets/loading_indecator.dart';
import 'package:autro_app/core/widgets/standard_card.dart';
import 'package:autro_app/features/proformas/presentation/bloc/supplier_proforma_form/supplier_proforma_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/supplier_proforma_form/supplier_proforma_form.dart';

class SupplierProformaFormDesktopLayout extends StatelessWidget {
  const SupplierProformaFormDesktopLayout({super.key, required this.formType});
  final FormType formType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocBuilder<SupplierProformaFormBloc, SupplierProformaFormState>(
        builder: (context, state) {
          if (state is SupplierProformaInfoInitial) {
            return const LoadingIndicator();
          } else if (state is SupplierProformaFormLoaded) {
            return const SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: StandardCard(
                  title: 'Supplier Proforma Information',
                  child: SupplierProformaForm(),
                ),
              ),
            );
          } else if (state is SupplierProformaFormError) {
            return FailureScreen(
              failure: state.failure,
              onRetryTap: () {
                context.read<SupplierProformaFormBloc>().add(SupplierProformaHandleFailure());
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
        return 'Edit Supplier Proforma';
      case FormType.create:
        return 'Add New Supplier Proforma';
      default:
        return 'Supplier Proforma';
    }
  }
}
