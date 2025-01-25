part of 'shipping_invoices_list_bloc.dart';

sealed class ShippingInvoicesListState extends Equatable {
  const ShippingInvoicesListState();

  @override
  List<Object> get props => [];
}

final class ShippingInvoicesListInitial extends ShippingInvoicesListState {}

final class ShippingInvoicesListLoaded extends ShippingInvoicesListState {
  final PaginationFilterDTO paginationFilterDTO;
  final List<ShippingInvoiceEntity> shippingInvoicesList;
  final int totalCount;
  final bool loading;
  final bool loadingPagination;
  final Option<Either<Failure, String>> failureOrSuccessOption;
  const ShippingInvoicesListLoaded({
    required this.shippingInvoicesList,
    required this.totalCount,
    required this.paginationFilterDTO,
    this.loading = false,
    this.loadingPagination = false,
    this.failureOrSuccessOption = const None(),
  });
  @override
  List<Object> get props => [
        shippingInvoicesList,
        paginationFilterDTO,
        totalCount,
        loading,
        failureOrSuccessOption,
        loadingPagination,
      ];

  ShippingInvoicesListLoaded copyWith({
    List<ShippingInvoiceEntity>? shippingInvoicesList,
    PaginationFilterDTO? paginationFilterDTO,
    int? totalCount,
    bool? loading,
    Option<Either<Failure, String>>? failureOrSuccessOption,
    bool? loadingPagination,
  }) {
    return ShippingInvoicesListLoaded(
      shippingInvoicesList: shippingInvoicesList ?? this.shippingInvoicesList,
      paginationFilterDTO: paginationFilterDTO ?? this.paginationFilterDTO,
      totalCount: totalCount ?? this.totalCount,
      loading: loading ?? this.loading,
      failureOrSuccessOption: failureOrSuccessOption ?? none(),
      loadingPagination: loadingPagination ?? this.loadingPagination,
    );
  }

  bool get canGoNextPage => paginationFilterDTO.pageNumber < totalCount / paginationFilterDTO.pageSize && !loadingPagination;
  bool get canGoPreviousPage => paginationFilterDTO.pageNumber > 1 && !loadingPagination;
}

class ShippingInvoicesListError extends ShippingInvoicesListState {
  final Failure failure;

  const ShippingInvoicesListError({required this.failure});

  @override
  List<Object> get props => [failure];
}
