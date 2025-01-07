part of 'suppliers_list_bloc.dart';

sealed class SuppliersListState extends Equatable {
  const SuppliersListState();

  @override
  List<Object> get props => [];
}

final class SuppliersListInitial extends SuppliersListState {}

final class SuppliersListLoaded extends SuppliersListState {
  final List<SupplierEntity> suppliersList;
  final PaginationFilterDTO paginationFilterDTO;
  final int totalCount;
  final bool loading;
  final bool loadingPagination;
  final Option<Either<Failure, String>> failureOrSuccessOption;
  const SuppliersListLoaded({
    required this.suppliersList,
    required this.totalCount,
    required this.paginationFilterDTO,
    this.loading = false,
    this.loadingPagination = false,
    this.failureOrSuccessOption = const None(),
  });
  @override
  List<Object> get props => [
        suppliersList,
        paginationFilterDTO,
        totalCount,
        loading,
        failureOrSuccessOption,
        loadingPagination,
      ];

  SuppliersListLoaded copyWith({
    List<SupplierEntity>? suppliersList,
    PaginationFilterDTO? paginationFilterDTO,
    int? totalCount,
    bool? loading,
    Option<Either<Failure, String>>? failureOrSuccessOption,
    bool? loadingPagination,
  }) {
    return SuppliersListLoaded(
      suppliersList: suppliersList ?? this.suppliersList,
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

class SuppliersListError extends SuppliersListState {
  final Failure failure;

  const SuppliersListError({required this.failure});

  @override
  List<Object> get props => [failure];
}
