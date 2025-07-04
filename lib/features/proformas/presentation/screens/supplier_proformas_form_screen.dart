import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/di/di.dart';
import 'package:autro_app/core/widgets/adaptive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/supplier_proforma_form/supplier_proforma_form_bloc.dart';
import 'layouts/desktop/supplier_proforma_form_desktop_layout.dart';

class SupplierProformaFormScreen extends StatelessWidget {
  const SupplierProformaFormScreen({super.key, this.supplierProformaId, required this.formType});
  final int? supplierProformaId;
  final FormType formType;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<SupplierProformaFormBloc>()..add(InitialSupplierProformaFormEvent(supplierProformaId: supplierProformaId)),
      child: AdaptiveLayout(
        mobile: (context) => const Center(
          child: Text('Supplier Proformas Mobile Layout'),
        ),
        desktop: (context) => SupplierProformaFormDesktopLayout(formType: formType),
      ),
    );
  }
}
