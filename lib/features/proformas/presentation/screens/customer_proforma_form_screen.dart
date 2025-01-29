import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/di/di.dart';
import 'package:autro_app/core/widgets/adaptive_layout.dart';
import 'package:autro_app/features/proformas/domin/entities/customer_proforma_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/customer_proforma_form_cubit/customer_proforma_form_cubit.dart';
import 'layouts/desktop/customer_proforma_form_desktop_layout.dart';

class ProformaFormScreen extends StatelessWidget {
  const ProformaFormScreen({super.key, this.proforma, required this.formType});
  final CustomerProformaEntity? proforma;
  final FormType formType;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProformaFormCubit>()..init(proforma: proforma),
      child: AdaptiveLayout(
        mobile: (context) => const Center(
          child: Text('Proformas Mobile Layout'),
        ),
        desktop: (context) => CustomerProformaFormDesktopLayout(formType: formType),
      ),
    );
  }
}
