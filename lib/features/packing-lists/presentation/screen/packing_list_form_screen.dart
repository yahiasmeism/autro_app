import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/di/di.dart';
import 'package:autro_app/core/widgets/adaptive_layout.dart';
import 'package:autro_app/features/packing-lists/presentation/bloc/packing_list_form/packing_list_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domin/entities/packing_list_entity.dart';
import 'packing_list_form_desktop_layout.dart';

class PackingListFormScreen extends StatelessWidget {
  const PackingListFormScreen({super.key, this.packingList, required this.formType});
  final PackingListEntity? packingList;
  final FormType formType;

  static const routeName = 'packing-list-form';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PackingListFormCubit>()..init(packingList: packingList),
      child: AdaptiveLayout(
        mobile: (context) => const Center(
          child: Text('Invoices Mobile Layout'),
        ),
        desktop: (context) => PackingListFormDesktopLayout(formType: formType),
      ),
    );
  }
}
