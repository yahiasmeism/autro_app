import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/widgets/inputs/standard_search_input.dart';
import 'package:autro_app/features/proformas/presentation/bloc/customers_proformas_list/customers_proformas_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerProformaSearchBar extends StatelessWidget {
  const CustomerProformaSearchBar({super.key});

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
            context.read<CustomersProformasListBloc>().add(SearchInputChangedEvent(keyword: keyword));
          },
        )),
      ]),
    );
  }
}
