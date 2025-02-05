part of 'deal_bills_list_bloc.dart';

sealed class DealBillsListState extends Equatable {
  const DealBillsListState();

  @override
  List<Object> get props => [];
}

final class DealBillsListInitial extends DealBillsListState {}

final class DealBillsListLoaded extends DealBillsListState {
  final int dealId;
  final PaginationFilterDTO paginationFilterDTO;
  final List<DealBillEntity> dealBillsList;
  final int totalCount;
  final bool loading;
  final bool loadingPagination;
  final Option<Either<Failure, String>> failureOrSuccessOption;
  const DealBillsListLoaded({
    required this.dealBillsList,
    required this.totalCount,
    required this.paginationFilterDTO,
    this.loading = false,
    this.loadingPagination = false,
    this.failureOrSuccessOption = const None(),
    required this.dealId,
  });
  @override
  List<Object> get props => [
        dealBillsList,
        paginationFilterDTO,
        totalCount,
        loading,
        failureOrSuccessOption,
        loadingPagination,
        dealId,
      ];

  DealBillsListLoaded copyWith({
    List<DealBillEntity>? dealBillsList,
    PaginationFilterDTO? paginationFilterDTO,
    int? totalCount,
    bool? loading,
    Option<Either<Failure, String>>? failureOrSuccessOption,
    bool? loadingPagination,
    int? dealId,
  }) {
    return DealBillsListLoaded(
      dealBillsList: dealBillsList ?? this.dealBillsList,
      paginationFilterDTO: paginationFilterDTO ?? this.paginationFilterDTO,
      totalCount: totalCount ?? this.totalCount,
      loading: loading ?? this.loading,
      failureOrSuccessOption: failureOrSuccessOption ?? none(),
      loadingPagination: loadingPagination ?? this.loadingPagination,
      dealId: dealId ?? this.dealId,
    );
  }

  bool get canGoNextPage => paginationFilterDTO.pageNumber < totalCount / paginationFilterDTO.pageSize && !loadingPagination;
  bool get canGoPreviousPage => paginationFilterDTO.pageNumber > 1 && !loadingPagination;
}

class DealBillsListError extends DealBillsListState {
  final Failure failure;
  final int dealId;

  const DealBillsListError({required this.failure, required this.dealId});

  @override
  List<Object> get props => [failure, dealId];
}
