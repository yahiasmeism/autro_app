import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/di/di.dart';
import 'package:autro_app/core/widgets/adaptive_layout.dart';
import 'package:autro_app/features/suppliers/domin/entities/supplier_entity.dart';
import 'package:autro_app/features/suppliers/presentation/bloc/supplier_form/supplier_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'layouts/desktop/supplier_form_desktop_layout.dart';

class SupplierFormScreen extends StatelessWidget {
  const SupplierFormScreen({super.key, this.supplier, required this.formType});
  final SupplierEntity? supplier;
  final FormType formType;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SupplierFormBloc>()..add(InitialSupplierFormEvent(supplier: supplier)),
      child: AdaptiveLayout(
        mobile: (context) => const Center(
          child: Text('Suppliers Mobile Layout'),
        ),
        desktop: (context) => SupplierFormDesktopLayout(formType: formType),
      ),
    );
  }
}
