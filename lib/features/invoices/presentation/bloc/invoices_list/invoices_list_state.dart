part of 'invoices_list_bloc.dart';

sealed class InvoicesListState extends Equatable {
  const InvoicesListState();

  @override
  List<Object> get props => [];
}

final class InvoicesListInitial extends InvoicesListState {}

final class InvoicesListLoaded extends InvoicesListState {
  final List<InvoiceEntity> invoicesList;
  final PaginationFilterDTO paginationFilterDTO;
  final int totalCount;
  final bool loading;
  final bool loadingPagination;
  final Option<Either<Failure, String>> failureOrSuccessOption;
  const InvoicesListLoaded({
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

  InvoicesListLoaded copyWith({
    List<InvoiceEntity>? invoicesList,
    PaginationFilterDTO? paginationFilterDTO,
    int? totalCount,
    bool? loading,
    Option<Either<Failure, String>>? failureOrSuccessOption,
    bool? loadingPagination,
  }) {
    return InvoicesListLoaded(
      invoicesList: invoicesList ?? this.invoicesList,
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

class InvoicesListError extends InvoicesListState {
  final Failure failure;

  const InvoicesListError({required this.failure});

  @override
  List<Object> get props => [failure];
}
