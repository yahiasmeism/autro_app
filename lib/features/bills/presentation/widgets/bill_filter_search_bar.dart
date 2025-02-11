import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/widgets/inputs/standard_search_input.dart';
import 'package:autro_app/features/bills/presentation/bloc/bills_list/bills_list_bloc.dart';
import 'package:autro_app/features/bills/presentation/widgets/bill_filter_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BillSearchBar extends StatelessWidget {
  const BillSearchBar({super.key});

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
            context.read<BillsListBloc>().add(SearchInputChangedEvent(keyword: keyword));
          },
        )),
        buildFilterButton(context),
      ]),
    );
  }

  Widget buildFilterButton(BuildContext context) {
    return BlocBuilder<BillsListBloc, BillsListState>(
      builder: (context, state) {
        if (state is! BillsListLoaded) return const SizedBox.shrink();
        return Badge(
          backgroundColor: Colors.red,
          alignment: const Alignment(-.45, -.55),
          isLabelVisible: state.filterDto.isSome(),
          largeSize: 8,
          smallSize: 8,
          child: Container(
            color: AppColors.scaffoldBackgroundColor,
            child: IconButton(
              icon: const Icon(Icons.filter_alt_outlined, size: 28),
              onPressed: !state.loading
                  ? () {
                      BillsFilterDialog.show(
                        context,
                        filter: state.filterDto.fold(
                          () => null,
                          (a) => a,
                        ),
                      );
                    }
                  : null,
            ),
          ),
        );
      },
    );
  }
}
