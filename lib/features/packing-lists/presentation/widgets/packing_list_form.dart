import 'package:autro_app/features/packing-lists/presentation/bloc/packing_list_form/packing_list_form_cubit.dart';
import 'package:autro_app/features/packing-lists/presentation/widgets/customer_invoice_form_details.dart';
import 'package:autro_app/features/packing-lists/presentation/widgets/packing_list_form_actions.dart';
import 'package:autro_app/features/packing-lists/presentation/widgets/packing_list_form_good_descriptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PackingListForm extends StatelessWidget {
  const PackingListForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PackingListFormCubit, PackingListFormState>(
      builder: (context, state) {
        return Form(
          key: context.read<PackingListFormCubit>().formKey,
          child: const Column(
            children: [
              PackingListFormDetails(),
              SizedBox(height: 24),
              PackingListFormGoodDescriptions(),
              SizedBox(height: 24),
              PackingListFormActions(),
            ],
          ),
        );
      },
    );
  }
}
