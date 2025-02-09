import 'package:autro_app/core/widgets/inputs/standard_input.dart';
import 'package:autro_app/core/widgets/standard_card.dart';
import 'package:autro_app/features/proformas/presentation/bloc/customer_proforma_form_cubit/customer_proforma_form_cubit.dart';
import 'package:autro_app/features/customers/presentation/widgets/customers_list_selection_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProformaFormCustomerInformation extends StatelessWidget {
  const ProformaFormCustomerInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CustomerProformaFormCubit>();

    return StandardCard(
      title: 'Customer Information',
      child: Row(
        children: [
          Expanded(
            child: CustomersListSelectionField(
              onItemTap: (customer) {
                bloc.customerAddressController.text = customer.formattedAddress;
              },
              nameController: bloc.customerNameController,
              idController: bloc.customerIdController,
            ),
          ),
          const SizedBox(
            width: 32,
          ),
          Expanded(
            child: StandardInput(
              labelText: 'Tax ID',
              hintText: 'e.g XXXX30283-9-00',
              controller: bloc.taxIdController,
            ),
          ),
        ],
      ),
    );
  }
}
