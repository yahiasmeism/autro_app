part of 'bills_list_bloc.dart';

sealed class BillsListState extends Equatable {
  const BillsListState();

  @override
  List<Object> get props => [];
}

final class BillsListInitial extends BillsListState {}

final class BillsListLoaded extends BillsListState {
  final List<BillEntity> billsList;
  final PaginationFilterDTO paginationFilterDTO;
  final int totalCount;
  final bool loading;
  final bool loadingPagination;
  final Option<Either<Failure, String>> failureOrSuccessOption;
  const BillsListLoaded({
    required this.billsList,
    required this.totalCount,
    required this.paginationFilterDTO,
    this.loading = false,
    this.loadingPagination = false,
    this.failureOrSuccessOption = const None(),
  });
  @override
  List<Object> get props => [
        billsList,
        paginationFilterDTO,
        totalCount,
        loading,
        failureOrSuccessOption,
        loadingPagination,
      ];

  BillsListLoaded copyWith({
    List<BillEntity>? billsList,
    PaginationFilterDTO? paginationFilterDTO,
    int? totalCount,
    bool? loading,
    Option<Either<Failure, String>>? failureOrSuccessOption,
    bool? loadingPagination,
  }) {
    return BillsListLoaded(
      billsList: billsList ?? this.billsList,
      paginationFilterDTO: paginationFilterDTO ?? this.paginationFilterDTO,
      totalCount: totalCount ?? this.totalCount,
      loading: loading ?? this.loading,
      failureOrSuccessOption: failureOrSuccessOption ?? none(),
      loadingPagination: loadingPagination ?? this.loadingPagination,
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
