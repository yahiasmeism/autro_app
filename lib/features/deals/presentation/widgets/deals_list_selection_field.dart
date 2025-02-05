import 'package:autro_app/core/common/data/models/selectable_item_model.dart';
import 'package:autro_app/core/di/di.dart';
import 'package:autro_app/core/errors/failure_mapper.dart';
import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/widgets/failure_screen.dart';
import 'package:autro_app/core/widgets/inputs/standard_search_input.dart';
import 'package:autro_app/core/widgets/overley_loading.dart';
import 'package:autro_app/features/deals/domin/entities/deal_entity.dart';
import 'package:autro_app/features/deals/presentation/bloc/deals_list/deals_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DealsListSelectionField extends StatefulWidget {
  const DealsListSelectionField({
    super.key,
    required this.idController,
    required this.seriesNumberController,
    this.onItemTap,
    this.enabled = true,
  });

  final TextEditingController seriesNumberController, idController;
  final Function(DealEntity deal)? onItemTap;
  final bool enabled;

  @override
  State createState() => _DealsListSelectionFieldState();
}

class _DealsListSelectionFieldState extends State<DealsListSelectionField> {
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
      child: Text('Deal Number', style: TextStyles.font16Regular),
    );
  }

  Widget _buildField() {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: widget.enabled
          ? () async {
              final value = await showCustomDialog();
              if (value != null) {
                widget.seriesNumberController.text = value.label;
                widget.idController.text = value.value.id.toString();
                widget.onItemTap?.call(value.value);
              }
            }
          : null,
      child: TextFormField(
        style: TextStyles.font16Regular,
        readOnly: true,
        textAlignVertical: TextAlignVertical.center,
        controller: widget.seriesNumberController,
        decoration: widget.enabled
            ? InputDecoration(
                enabled: widget.enabled,
                contentPadding: const EdgeInsets.all(16),
                hintText: 'Select Deal',
                suffixIcon: const Icon(Icons.keyboard_arrow_down),
              )
            : null,
        enabled: false,
      ),
    );
  }

  Future<SelectableItemModel<DealEntity>?> showCustomDialog() async {
    return showDialog<SelectableItemModel<DealEntity>?>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Dialog(
            clipBehavior: Clip.antiAlias,
            backgroundColor: Colors.white,
            insetPadding: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: BlocProvider(
              create: (context) => sl<DealsListBloc>()..add(GetDealsListEvent()),
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
                                  context.read<DealsListBloc>().add(SearchInputChangedEvent(keyword: keyword));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: BlocConsumer<DealsListBloc, DealsListState>(
                          listener: (context, state) {
                            if (state is DealsListLoaded) {
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
                            if (state is DealsListInitial) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (state is DealsListLoaded) {
                              if (!state.loadingPagination) hasPagination = false;
                              return Stack(
                                children: [
                                  _buildList(state, context),
                                  if (state.loading) const Positioned.fill(child: LoadingOverlay()),
                                ],
                              );
                            } else if (state is DealsListError) {
                              return FailureScreen(
                                failure: state.failure,
                                onRetryTap: () => context.read<DealsListBloc>().add(HandleFailureEvent()),
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
          Text('Select Deal', style: TextStyles.font20Regular),
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

  Widget _buildList(DealsListLoaded state, BuildContext context) {
    if (state.dealsList.isEmpty) {
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
          context.read<DealsListBloc>().add(LoadMoreDealsEvent());
        }
        return false;
      },
      child: ListView.separated(
        separatorBuilder: (context, index) => const Divider(height: 0),
        controller: scrollController,
        itemCount: state.loadingPagination ? state.dealsList.length + 1 : state.dealsList.length,
        itemBuilder: (context, index) {
          if (index == state.dealsList.length) {
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
          final item = state.dealsList[index];
          final isSelected = item.id.toString() == widget.idController.text;
          return ListTile(
            selectedTileColor: Colors.black12,
            tileColor: Colors.white,
            trailing: isSelected ? const Icon(Icons.check, color: AppColors.deepGreen) : null,
            selectedColor: Colors.black12,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text(item.dealNumber, style: TextStyles.font16Regular),
            onTap: () {
              Navigator.pop(context, SelectableItemModel<DealEntity>(label: item.dealNumber, value: item));
            },
          );
        },
      ),
    );
  }
}
