import 'package:autro_app/core/common/data/models/selectable_item_model.dart';
import 'package:autro_app/core/di/di.dart';
import 'package:autro_app/core/errors/failure_mapper.dart';
import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/widgets/failure_screen.dart';
import 'package:autro_app/features/settings/presentation/bloc/bank_accounts_list/bank_accounts_list_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BankAccountsListSelectionField extends StatefulWidget {
  const BankAccountsListSelectionField({
    super.key,
    required this.nameController,
    required this.idController,
    this.canOpenDialog = true,
  });

  final TextEditingController nameController, idController;
  final bool canOpenDialog;

  @override
  State createState() => _BankAccountsListSelectionFieldState();
}

class _BankAccountsListSelectionFieldState extends State<BankAccountsListSelectionField> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(),
        _buildField(),
      ],
    );
  }

  Widget _buildLabel() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text('BankAccount Name', style: TextStyles.font16Regular),
    );
  }

  Widget _buildField() {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: widget.canOpenDialog
          ? () async {
              final value = await showCustomDialog();
              if (value != null) {
                widget.nameController.text = value.label;
                widget.idController.text = value.value;
              }
            }
          : null,
      child: TextFormField(
        style: TextStyles.font16Regular,
        readOnly: true,
        textAlignVertical: TextAlignVertical.center,
        controller: widget.nameController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(16),
          hintText: 'Select Bank Account',
          suffixIcon: widget.canOpenDialog ? const Icon(Icons.keyboard_arrow_down) : null,
        ),
        enabled: !widget.canOpenDialog,
      ),
    );
  }

  Future<SelectableItemModel<String>?> showCustomDialog() async {
    return showDialog<SelectableItemModel<String>?>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Dialog(
            clipBehavior: Clip.antiAlias,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: BlocProvider(
              create: (context) => sl<BankAccountsListCubit>()..getBankAccountList(),
              child: SizedBox(
                width: 600,
                height: 400,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDialogHeader(context),
                      const Divider(),
                      const SizedBox(height: 16),
                      Expanded(
                        child: BlocConsumer<BankAccountsListCubit, BankAccountsListState>(
                          listener: (context, state) {
                            if (state is BankAccountsListLoaded) {
                              state.failureOrSuccessOption.fold(
                                () => null,
                                (either) {
                                  either.fold(
                                    (failure) => DialogUtil.showErrorSnackBar(
                                      context,
                                      getErrorMsgFromFailure(failure),
                                    ),
                                    (_) => null,
                                  );
                                },
                              );
                            }
                          },
                          builder: (context, state) {
                            if (state is BankAccountsListInitial) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (state is BankAccountsListLoaded) {
                              return _buildList(state);
                            } else if (state is BankAccountsListError) {
                              return FailureScreen(
                                failure: state.failure,
                                onRetryTap: () => context.read<BankAccountsListCubit>().onHandleError(),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDialogHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.scaffoldBackgroundColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Text('Select Bank Account', style: TextStyles.font20Regular),
          const Spacer(),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
            splashRadius: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildList(BankAccountsListLoaded state) {
    if (state.bankAccountsList.isEmpty) {
      return Center(child: Text('No Results Found', style: TextStyles.font16Regular));
    }

    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(height: 0),
      controller: scrollController,
      itemCount: state.bankAccountsList.length,
      itemBuilder: (context, index) {
        final item = state.bankAccountsList[index];
        final isSelected = item.id.toString() == widget.idController.text;
        return ListTile(
          selectedTileColor: Colors.black12,
          tileColor: Colors.white,
          trailing: isSelected ? const Icon(Icons.check, color: AppColors.deepGreen) : null,
          selectedColor: Colors.black12,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: Text(item.formattedLabel, style: TextStyles.font16Regular),
          onTap: () {
            Navigator.pop(context, SelectableItemModel<String>(label: item.formattedLabel, value: item.id.toString()));
          },
        );
      },
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
