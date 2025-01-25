import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/widgets/overley_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bill_form/bill_form_bloc.dart';
import '../../widgets/bill_form.dart';

class BillFormDesktopLayout extends StatelessWidget {
  const BillFormDesktopLayout({super.key, required this.formType});
  final FormType formType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocBuilder<BillFormBloc, BillFormState>(
        builder: (context, state) {
          if (state is BillFormLoaded) {
            return Stack(
              children: [
                const Positioned.fill(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: BillForm(),
                    ),
                  ),
                ),
                if (state.loading) const LoadingOverlay(),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  String get title {
    switch (formType) {
      case FormType.edit:
        return 'Edit Bill';
      case FormType.create:
        return 'Add New Bill';
      default:
        return 'Bill';
    }
  }
}
