part of 'bills_list_bloc.dart';

sealed class BillsListState extends Equatable {
  const BillsListState();

  @override
  List<Object?> get props => [];
}

final class BillsListInitial extends BillsListState {}

final class BillsListLoaded extends BillsListState {
  final BillsSummaryEntity? billsSummary;
  final List<BillEntity> billsList;
  final PaginationFilterDTO paginationFilterDTO;
  final int totalCount;
  final bool loading;
  final bool loadingPagination;
  final bool loadingSummary;
  final Option<Either<Failure, String>> failureOrSuccessOption;
  const BillsListLoaded({
    required this.billsList,
    required this.totalCount,
    required this.paginationFilterDTO,
    this.loading = false,
    this.loadingPagination = false,
    this.failureOrSuccessOption = const None(),
    this.billsSummary,
    this.loadingSummary = true,
  });
  @override
  List<Object?> get props => [
        billsList,
        paginationFilterDTO,
        totalCount,
        loading,
        failureOrSuccessOption,
        loadingPagination,
        billsSummary,
        loadingSummary,
      ];

  BillsListLoaded copyWith({
    List<BillEntity>? billsList,
    PaginationFilterDTO? paginationFilterDTO,
    BillsSummaryEntity? billsSummary,
    int? totalCount,
    bool? loading,
    Option<Either<Failure, String>>? failureOrSuccessOption,
    bool? loadingPagination,
    bool? loadingSummary,
  }) {
    return BillsListLoaded(
      billsList: billsList ?? this.billsList,
      paginationFilterDTO: paginationFilterDTO ?? this.paginationFilterDTO,
      totalCount: totalCount ?? this.totalCount,
      loading: loading ?? this.loading,
      failureOrSuccessOption: failureOrSuccessOption ?? none(),
      loadingPagination: loadingPagination ?? this.loadingPagination,
      billsSummary: billsSummary ?? this.billsSummary,
      loadingSummary: loadingSummary ?? this.loadingSummary,
    );
  }

  int get totalPages => ((totalCount) / paginationFilterDTO.pageSize).ceil();
  bool get canGoNextPage => paginationFilterDTO.pageNumber < totalCount / paginationFilterDTO.pageSize && !loadingPagination;
  bool get canGoPreviousPage => paginationFilterDTO.pageNumber > 1 && !loadingPagination;
}

class BillsListError extends BillsListState {
  final Failure failure;

  const BillsListError({required this.failure});

  @override
  List<Object> get props => [failure];
}
