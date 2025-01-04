import 'package:autro_app/core/di/di.dart';
import 'package:autro_app/features/customers/presentation/bloc/customers_list/customers_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/adaptive_layout.dart';
import 'layouts/desktop/customers_list_desktop_layout.dart';

class CustomersListScreen extends StatelessWidget {
  const CustomersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CustomersListBloc>()..add(GetCustomersListEvent()),
      child: AdaptiveLayout(
        mobile: (context) => const Center(child: Text('Customers Mobile Layout')),
        desktop: (context) => const CustomersListDesktopLayout(),
      ),
    );
  }
}
