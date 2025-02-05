import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/di/di.dart';
import 'package:autro_app/core/widgets/adaptive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domin/entities/deal_bill_entity.dart';
import '../bloc/deal_bill_form/deal_bill_form_bloc.dart';
import 'layouts/desktop/deal_bill_form_desktop_layout.dart';

class DealBillFormScreen extends StatelessWidget {
  const DealBillFormScreen({super.key, this.dealBill, required this.formType, required this.dealId});
  final DealBillEntity? dealBill;
  final int dealId;
  final FormType formType;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DealBillFormBloc>()..add(InitialDealBillFormEvent(dealBill: dealBill, dealId: dealId)),
      child: AdaptiveLayout(
        mobile: (context) => const Center(
          child: Text('Bills Mobile Layout'),
        ),
        desktop: (context) => DealBillFormDesktopLayout(formType: formType),
      ),
    );
  }
}
