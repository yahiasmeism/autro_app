import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/di/di.dart';
import 'package:autro_app/core/widgets/adaptive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bl_instruction_form/bl_instruction_bloc.dart';
import 'layouts/bl_instructions_form_desktop_layout.dart';

class BlInsturctionFormScreen extends StatelessWidget {
  const BlInsturctionFormScreen({super.key, this.id, required this.formType});
  final int? id;
  final FormType formType;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<BlInstructionFormBloc>()..add(InitialBlInstructionFormEvent(id: id)),
      child: AdaptiveLayout(
        mobile: (context) => const Center(
          child: Text('Shipping Invoices Mobile Layout'),
        ),
        desktop: (context) => BlInsturctionFormDesktopLayout(formType: formType),
      ),
    );
  }
}
