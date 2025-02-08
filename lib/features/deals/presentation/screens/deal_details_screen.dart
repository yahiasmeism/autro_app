import 'package:autro_app/core/widgets/adaptive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/deal_details/deal_details_cubit.dart';
import 'layouts/desktop/deal_details_desktop_layout.dart';

class DealDetailsScreen extends StatelessWidget {
  const DealDetailsScreen({super.key, required this.dealId});
  final int dealId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<DealDetailsCubit>()..init(dealId),
      child: AdaptiveLayout(
        mobile: (context) => const Center(child: Text('Deals Mobile Layout')),
        desktop: (context) => const DealDetailsDesktopLayout(),
      ),
    );
  }
}
