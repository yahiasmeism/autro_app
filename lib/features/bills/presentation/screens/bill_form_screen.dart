import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/di/di.dart';
import 'package:autro_app/core/widgets/adaptive_layout.dart';
import 'package:autro_app/features/bills/presentation/bloc/bill_form/bill_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'layouts/bill_form_desktop_layout.dart';

class BillFormScreen extends StatelessWidget {
  const BillFormScreen({super.key, this.billId, required this.formType});
  final int? billId;
  final FormType formType;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<BillFormBloc>()..add(InitialBillFormEvent(billId: billId)),
      child: AdaptiveLayout(
        mobile: (context) => const Center(
          child: Text('Bills Mobile Layout'),
        ),
        desktop: (context) => BillFormDesktopLayout(formType: formType),
      ),
    );
  }
}
