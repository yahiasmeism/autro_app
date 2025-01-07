import 'package:autro_app/core/di/di.dart';
import 'package:autro_app/features/suppliers/presentation/bloc/suppliers_list/suppliers_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/adaptive_layout.dart';
import 'layouts/desktop/suppliers_list_desktop_layout.dart';

class SuppliersListScreen extends StatelessWidget {
  const SuppliersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SuppliersListBloc>()..add(GetSuppliersListEvent()),
      child: AdaptiveLayout(
        mobile: (context) => const Center(child: Text('Suppliers Mobile Layout')),
        desktop: (context) => const SuppliersListDesktopLayout(),
      ),
    );
  }
}
