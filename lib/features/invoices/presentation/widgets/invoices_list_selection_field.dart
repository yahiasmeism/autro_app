// ignore_for_file: deprecated_member_use

import 'package:autro_app/core/common/data/models/selectable_item_model.dart';
import 'package:autro_app/core/di/di.dart';
import 'package:autro_app/core/errors/failure_mapper.dart';
import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/widgets/failure_screen.dart';
import 'package:autro_app/core/widgets/inputs/standard_search_input.dart';
import 'package:autro_app/core/widgets/loading_indecator.dart';
import 'package:autro_app/core/widgets/overley_loading.dart';
import 'package:autro_app/features/invoices/presentation/bloc/customers_invoices_list/customers_invoices_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InvoicesListSelectionField extends StatefulWidget {
  const InvoicesListSelectionField(
      {super.key, required this.invoiceNumberController, required this.idController, this.enableOpenDialog = true});

  final TextEditingController invoiceNumberController, idController;
  final bool enableOpenDialog;

  @override
  State createState() => _InvoicesListSelectionFieldState();
}

class _InvoicesListSelectionFieldState extends State<InvoicesListSelectionField> {
  final ScrollController scrollController = ScrollController();
  bool hasPagination = false;

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
      child: Text('Invoice Number', style: TextStyles.font16Regular),
    );
  }

  Widget _buildField() {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: widget.enableOpenDialog
          ? () async {
              final value = await showCustomDialog();
              if (value != null) {
                widget.invoiceNumberController.text = value.label;
                widget.idController.text = value.value;
              }
            }
          : null,
      child: MouseRegion(
        cursor: widget.enableOpenDialog ? SystemMouseCursors.click : MouseCursor.defer,
        child: TextFormField(
          style: TextStyles.font16Regular,
          readOnly: true,
          textAlignVertical: TextAlignVertical.center,
          controller: widget.invoiceNumberController,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(16),
            hintText: 'Select Invoice',
            suffixIcon: Icon(Icons.keyboard_arrow_down),
          ),
          enabled: !widget.enableOpenDialog,
        ),
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
          body: BlocProvider(
            create: (context) => sl<CustomersInvoicesListBloc>()..add(GetCustomersInvoicesListEvent()),
            child: Dialog(
              clipBehavior: Clip.antiAlias,
              backgroundColor: Colors.white,
              insetPadding: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: SizedBox(
                width: 600,
                height: 500,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            _buildDialogHeader(context),
                            const Divider(),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: StandardSearchInput(
                                onSearch: (context, keyword) {
                                  context.read<CustomersInvoicesListBloc>().add(SearchInputChangedEvent(keyword: keyword));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: BlocConsumer<CustomersInvoicesListBloc, CustomersInvoicesListState>(
                          listener: (context, state) {
                            if (state is CustomersInvoicesListLoaded) {
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
                            if (state is CustomersInvoicesListInitial) {
                              return const LoadingIndicator();
                            } else if (state is CustomersInvoicesListLoaded) {
                              if (!state.loadingPagination) hasPagination = false;
                              return Stack(
                                children: [
                                  _buildList(state, context),
                                  if (state.loading) const Positioned.fill(child: LoadingOverlay()),
                                ],
                              );
                            } else if (state is CustomersInvoicesListError) {
                              return FailureScreen(
                                failure: state.failure,
                                onRetryTap: () => context.read<CustomersInvoicesListBloc>().add(HandleFailureEvent()),
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
      decoration: const BoxDecoration(
        color: AppColors.scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Text('Select Invoice', style: TextStyles.font20Regular),
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

  Widget _buildList(CustomersInvoicesListLoaded state, BuildContext context) {
    if (state.invoicesList.isEmpty) {
      return Center(
        child: Text(
          'No Results Found',
          style: TextStyles.font16Regular,
        ),
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification &&
            scrollController.position.pixels >= scrollController.position.maxScrollExtent * 0.9 &&
            !state.loadingPagination) {
          context.read<CustomersInvoicesListBloc>().add(LoadMoreCustomersInvoicesEvent());
        }
        return false;
      },
      child: ListView.separated(
        separatorBuilder: (context, index) => const Divider(height: 0),
        controller: scrollController,
        itemCount: state.loadingPagination ? state.invoicesList.length + 1 : state.invoicesList.length,
        itemBuilder: (context, index) {
          if (index == state.invoicesList.length) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                    strokeAlign: 0.0,
                  ),
                ),
              ),
            );
          }
          final item = state.invoicesList[index];
          final isSelected = item.id.toString() == widget.idController.text;
          return ListTile(
            selectedTileColor: Colors.black12,
            tileColor: Colors.white,
            trailing: isSelected ? const Icon(Icons.check, color: AppColors.deepGreen) : null,
            selectedColor: Colors.black12,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text(item.invoiceNumber, style: TextStyles.font16Regular),
            onTap: () {
              Navigator.pop(context, SelectableItemModel<String>(label: item.invoiceNumber, value: item.id.toString()));
              context.read<CustomersInvoicesListBloc>().add(const SearchInputChangedEvent(keyword: ''));
            },
          );
        },
      ),
    );
  }
}
