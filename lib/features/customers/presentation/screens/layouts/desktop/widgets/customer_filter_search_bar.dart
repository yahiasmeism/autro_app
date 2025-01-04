import 'package:autro_app/core/di/di.dart';
import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/widgets/inputs/standard_search_input.dart';
import 'package:autro_app/features/customers/presentation/bloc/customers_list/customers_list_bloc.dart';
import 'package:flutter/material.dart';

class CustomerSearchBar extends StatelessWidget {
  const CustomerSearchBar({super.key});

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
            sl<CustomersListBloc>().add(SearchInputChangedEvent(keyword: keyword));
          },
        )),
      ]),
    );
  }
}
