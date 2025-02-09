import 'package:autro_app/core/widgets/inputs/standard_input.dart';
import 'package:autro_app/core/widgets/standard_card.dart';
import 'package:autro_app/features/customers/presentation/widgets/customers_list_selection_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/customer_invoice_form/customer_invoice_form_cubit.dart';

class CustomerInvoiceFormCustomerInformation extends StatelessWidget {
  const CustomerInvoiceFormCustomerInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CustomerInvoiceFormCubit>();

    return StandardCard(
      title: 'Customer Information',
      child: Row(
        children: [
          Expanded(
            child: CustomersListSelectionField(
              enableOpenDialog: false,
              nameController: bloc.customerNameController,
              idController: bloc.customerIdController,
              onItemTap: (customer) {
                bloc.customerAddressController.text = customer.formattedAddress;
              },
            ),
          ),
          const SizedBox(
            width: 32,
          ),
          Expanded(
            child: StandardInput(
              readOnly: true,
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
