import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/widgets/failure_screen.dart';
import 'package:autro_app/core/widgets/loading_indecator.dart';
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
          if (state is BillInfoInitial) {
            return const LoadingIndicator();
          } else if (state is BillFormLoaded) {
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
          } else if (state is BillFormError) {
            return FailureScreen(
              failure: state.failure,
              onRetryTap: () {
                context.read<BillFormBloc>().add(BillFormHandleError());
              },
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
