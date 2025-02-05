part of 'suppliers_invoices_list_bloc.dart';

sealed class SuppliersInvoicesListState extends Equatable {
  const SuppliersInvoicesListState();

  @override
  List<Object> get props => [];
}

final class SuppliersInvoicesListInitial extends SuppliersInvoicesListState {}

final class SuppliersInvoicesListLoaded extends SuppliersInvoicesListState {
  final List<SupplierInvoiceEntity> invoicesList;
  final PaginationFilterDTO paginationFilterDTO;
  final int totalCount;
  final bool loading;
  final bool loadingPagination;
  final Option<Either<Failure, String>> failureOrSuccessOption;
  const SuppliersInvoicesListLoaded({
    required this.invoicesList,
    required this.totalCount,
    required this.paginationFilterDTO,
    this.loading = false,
    this.loadingPagination = false,
    this.failureOrSuccessOption = const None(),
  });
  @override
  List<Object> get props => [
        invoicesList,
        paginationFilterDTO,
        totalCount,
        loading,
        failureOrSuccessOption,
        loadingPagination,
      ];

  SuppliersInvoicesListLoaded copyWith({
    List<SupplierInvoiceEntity>? invoicesList,
    PaginationFilterDTO? paginationFilterDTO,
    int? totalCount,
    bool? loading,
    Option<Either<Failure, String>>? failureOrSuccessOption,
    bool? loadingPagination,
  }) {
    return SuppliersInvoicesListLoaded(
      invoicesList: invoicesList ?? this.invoicesList,
      paginationFilterDTO: paginationFilterDTO ?? this.paginationFilterDTO,
      totalCount: totalCount ?? this.totalCount,
      loading: loading ?? this.loading,
      failureOrSuccessOption: failureOrSuccessOption ?? none(),
      loadingPagination: loadingPagination ?? this.loadingPagination,
    );
  }

  int get totalPages => (totalCount / paginationFilterDTO.pageSize).ceil();

  bool get canGoNextPage => paginationFilterDTO.pageNumber < totalCount / paginationFilterDTO.pageSize && !loadingPagination;
  bool get canGoPreviousPage => paginationFilterDTO.pageNumber > 1 && !loadingPagination;
}

class SuppliersInvoicesListError extends SuppliersInvoicesListState {
  final Failure failure;

  const SuppliersInvoicesListError({required this.failure});

  @override
  List<Object> get props => [failure];
}
