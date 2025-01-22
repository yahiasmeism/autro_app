import 'package:autro_app/core/common/data/models/selectable_item_model.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:autro_app/core/widgets/failure_screen.dart';
import 'package:autro_app/features/settings/presentation/bloc/bank_accounts_list/bank_accounts_list_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BankAccountsListSelectionField extends StatefulWidget {
  const BankAccountsListSelectionField({
    super.key,
    required this.nameController,
    required this.idController,
  });

  final TextEditingController nameController, idController;

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
      onTap: () async {
        final value = await showCustomDialog();
        if (value != null) {
          widget.nameController.text = value.label;
          widget.idController.text = value.value;
        }
      },
      child: TextFormField(
        style: TextStyles.font16Regular,
        readOnly: true,
        textAlignVertical: TextAlignVertical.center,
        controller: widget.nameController,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(16),
          hintText: 'Select Bank Account',
          suffixIcon: Icon(Icons.keyboard_arrow_down),
        ),
        enabled: false,
      ),
    );
  }

  Future<SelectableItemModel<String>?> showCustomDialog() async {
    return showDialog<SelectableItemModel<String>?>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: SizedBox(
            width: 600,
            height: 500,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDialogHeader(context),
                  const SizedBox(height: 16),
                  Expanded(
                    child: BlocBuilder<BankAccountsListCubit, BankAccountsListState>(
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
        );
      },
    );
  }

  Widget _buildDialogHeader(BuildContext context) {
    return Padding(
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

    return ListView.builder(
      controller: scrollController,
      itemCount: state.bankAccountsList.length,
      itemBuilder: (context, index) {
        final item = state.bankAccountsList[index];
        final isSelected = item.id.toString() == widget.idController.text;
        return ListTile(
          selectedTileColor: Colors.black12,
          tileColor: Colors.white,
          trailing: isSelected ? const Icon(Icons.check) : null,
          selectedColor: Colors.black12,
          selected: isSelected,
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
