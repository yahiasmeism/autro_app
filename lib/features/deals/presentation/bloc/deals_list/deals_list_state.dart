part of 'deals_list_bloc.dart';

sealed class DealsListState extends Equatable {
  const DealsListState();

  @override
  List<Object> get props => [];
}

final class DealsListInitial extends DealsListState {}

final class DealsListLoaded extends DealsListState {
  final List<DealEntity> dealsList;
  final PaginationFilterDTO paginationFilterDTO;
  final int totalCount;
  final bool loading;
  final bool loadingPagination;
  final Option<Either<Failure, String>> failureOrSuccessOption;
  const DealsListLoaded({
    required this.dealsList,
    required this.totalCount,
    required this.paginationFilterDTO,
    this.loading = false,
    this.loadingPagination = false,
    this.failureOrSuccessOption = const None(),
  });
  @override
  List<Object> get props => [
        dealsList,
        paginationFilterDTO,
        totalCount,
        loading,
        failureOrSuccessOption,
        loadingPagination,
      ];

  DealsListLoaded copyWith({
    List<DealEntity>? dealsList,
    PaginationFilterDTO? paginationFilterDTO,
    int? totalCount,
    bool? loading,
    Option<Either<Failure, String>>? failureOrSuccessOption,
    bool? loadingPagination,
  }) {
    return DealsListLoaded(
      dealsList: dealsList ?? this.dealsList,
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

class DealsListError extends DealsListState {
  final Failure failure;

  const DealsListError({required this.failure});

  @override
  List<Object> get props => [failure];
}
