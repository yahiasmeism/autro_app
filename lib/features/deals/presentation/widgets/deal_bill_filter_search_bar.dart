import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/widgets/inputs/standard_search_input.dart';
import 'package:autro_app/features/deals/presentation/bloc/deal_bills_list/deal_bills_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DealBillFilterSearchBar extends StatelessWidget {
  const DealBillFilterSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: AppColors.white,
      ),
      padding: const EdgeInsets.all(16),
      child: Row(children: [
        Expanded(child: StandardSearchInput(
          onSearch: (context, keyword) {
            context.read<DealBillsListBloc>().add(SearchInputChangedDealBillsEvent(keyword: keyword));
          },
        )),
      ]),
    );
  }
}
