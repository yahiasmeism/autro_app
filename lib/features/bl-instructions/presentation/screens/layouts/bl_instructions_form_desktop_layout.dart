import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/widgets/failure_screen.dart';
import 'package:autro_app/core/widgets/loading_indecator.dart';
import 'package:autro_app/core/widgets/standard_card.dart';
import 'package:autro_app/features/bl-instructions/presentation/bloc/bl_instruction_form/bl_instruction_bloc.dart';
import 'package:autro_app/features/bl-instructions/presentation/widgets/bl_instruction_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlInsturctionFormDesktopLayout extends StatelessWidget {
  const BlInsturctionFormDesktopLayout({super.key, required this.formType});
  final FormType formType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocBuilder<BlInstructionFormBloc, BlInstructionFormState>(
        builder: (context, state) {
          if (state is BlInstructionInfoInitial) {
            return const LoadingIndicator();
          } else if (state is BlInstructionFormLoaded) {
            return const SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: StandardCard(
                  title: 'BL Instruction',
                  child: BlInstructionForm(),
                ),
              ),
            );
          } else if (state is BlInstructionFormError) {
            return FailureScreen(
              failure: state.failure,
              onRetryTap: () {
                context.read<BlInstructionFormBloc>().add(BlInstructionFormHandleFailure());
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
        return 'Edit BL Instruction';
      case FormType.create:
        return 'Add New BL Instruction';
      default:
        return 'BL Instruction';
    }
  }
}
