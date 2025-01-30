part of 'customers_invoices_list_bloc.dart';

sealed class CustomersInvoicesListState extends Equatable {
  const CustomersInvoicesListState();

  @override
  List<Object> get props => [];
}

final class CustomersInvoicesListInitial extends CustomersInvoicesListState {}

final class CustomersInvoicesListLoaded extends CustomersInvoicesListState {
  final List<CustomerInvoiceEntity> invoicesList;
  final PaginationFilterDTO paginationFilterDTO;
  final int totalCount;
  final bool loading;
  final bool loadingPagination;
  final Option<Either<Failure, String>> failureOrSuccessOption;
  const CustomersInvoicesListLoaded({
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

  CustomersInvoicesListLoaded copyWith({
    List<CustomerInvoiceEntity>? invoicesList,
    PaginationFilterDTO? paginationFilterDTO,
    int? totalCount,
    bool? loading,
    Option<Either<Failure, String>>? failureOrSuccessOption,
    bool? loadingPagination,
  }) {
    return CustomersInvoicesListLoaded(
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

class CustomersInvoicesListError extends CustomersInvoicesListState {
  final Failure failure;

  const CustomersInvoicesListError({required this.failure});

  @override
  List<Object> get props => [failure];
}
