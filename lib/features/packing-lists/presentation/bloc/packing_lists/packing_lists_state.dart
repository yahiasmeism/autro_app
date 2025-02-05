part of 'packing_lists_bloc.dart';

sealed class PackingListsState extends Equatable {
  const PackingListsState();

  @override
  List<Object?> get props => [];
}

final class PackingListsInitial extends PackingListsState {}

final class PackingListsLoaded extends PackingListsState {
  final List<PackingListEntity> packingLists;
  final PaginationFilterDTO paginationFilterDTO;
  final int totalCount;
  final bool loading;
  final bool loadingPagination;
  final Option<Either<Failure, String>> failureOrSuccessOption;
  const PackingListsLoaded({
    required this.packingLists,
    required this.totalCount,
    required this.paginationFilterDTO,
    this.loading = false,
    this.loadingPagination = false,
    this.failureOrSuccessOption = const None(),
  });
  @override
  List<Object?> get props => [
        packingLists,
        paginationFilterDTO,
        totalCount,
        loading,
        failureOrSuccessOption,
        loadingPagination,
      ];

  PackingListsLoaded copyWith({
    List<PackingListEntity>? packingLists,
    PaginationFilterDTO? paginationFilterDTO,
    int? totalCount,
    bool? loading,
    Option<Either<Failure, String>>? failureOrSuccessOption,
    bool? loadingPagination,
  }) {
    return PackingListsLoaded(
      packingLists: packingLists ?? this.packingLists,
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

class PackingListsError extends PackingListsState {
  final Failure failure;

  const PackingListsError({required this.failure});

  @override
  List<Object> get props => [failure];
}
