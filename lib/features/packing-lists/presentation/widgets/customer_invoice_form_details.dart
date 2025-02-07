import 'package:autro_app/core/widgets/inputs/standard_input.dart';
import 'package:autro_app/core/widgets/standard_card.dart';
import 'package:autro_app/features/deals/presentation/widgets/deals_list_selection_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domin/dtos/packing_list_description_dto.dart';
import '../bloc/packing_list_form/packing_list_form_cubit.dart';

class PackingListFormDetails extends StatelessWidget {
  const PackingListFormDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PackingListFormCubit>();
    return StandardCard(
      title: 'Packing List Information',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: DealsListSelectionField(
              idController: bloc.dealIdController,
              seriesNumberController: bloc.numberController,
              onItemTap: (deal) {
                final customerInvoice = deal.customerInvoice;
                if (customerInvoice == null || customerInvoice.goodsDescriptions.isEmpty) return;
                List<PackingListDescriptionDto> descriptionList = [];

                for (int i = 0; i < customerInvoice.goodsDescriptions.length; i++) {
                  descriptionList.add(PackingListDescriptionDto(
                    uniqueKey: i.toString(),
                    containerNumber: customerInvoice.goodsDescriptions[i].containerNumber,
                    weight: customerInvoice.goodsDescriptions[i].weight,
                    emptyContainerWeight: 0,
                    type: null,
                    itemsCount: 0,
                    date: customerInvoice.goodsDescriptions[i].createdAt,
                    percento: '',
                  ));
                }

                bloc.addGoodsDescription(descriptionList);
              },
            ),
          ),
          const SizedBox(width: 32),
          Expanded(
            child: StandardInput(
              hintText: 'details',
              labelText: 'Details',
              controller: bloc.detailsController,
            ),
          ),
        ],
      ),
    );
  }
}
