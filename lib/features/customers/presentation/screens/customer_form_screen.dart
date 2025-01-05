import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/di/di.dart';
import 'package:autro_app/core/widgets/adaptive_layout.dart';
import 'package:autro_app/features/customers/domin/entities/customer_entity.dart';
import 'package:autro_app/features/customers/presentation/bloc/customer/customer_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'layouts/desktop/customer_form_desktop_layout.dart';

class CustomerFormScreen extends StatelessWidget {
  const CustomerFormScreen({super.key, this.customer, required this.formType});
  final CustomerEntity? customer;
  final FormType formType;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CustomerFormBloc>()
        ..add(InitialCustomerFormEvent(
          customer: customer,
          formType: formType,
        )),
      child: AdaptiveLayout(
        mobile: (context) => const Center(
          child: Text('Customers Mobile Layout'),
        ),
        desktop: (context) => CustomerInformationsDesktopLayout(formType: formType),
      ),
    );
  }
}
