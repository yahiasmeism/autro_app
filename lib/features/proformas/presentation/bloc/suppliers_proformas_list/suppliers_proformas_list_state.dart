part of 'suppliers_proformas_list_bloc.dart';

sealed class SuppliersProformasListState extends Equatable {
  const SuppliersProformasListState();

  @override
  List<Object> get props => [];
}

final class SuppliersProformasListInitial extends SuppliersProformasListState {}

final class SuppliersProformasListLoaded extends SuppliersProformasListState {
  final List<SupplierProformaEntity> proformasList;
  final PaginationFilterDTO paginationFilterDTO;
  final int totalCount;
  final bool loading;
  final bool loadingPagination;
  final Option<Either<Failure, String>> failureOrSuccessOption;
  const SuppliersProformasListLoaded({
    required this.proformasList,
    required this.totalCount,
    required this.paginationFilterDTO,
    this.loading = false,
    this.loadingPagination = false,
    this.failureOrSuccessOption = const None(),
  });
  @override
  List<Object> get props => [
        proformasList,
        paginationFilterDTO,
        totalCount,
        loading,
        failureOrSuccessOption,
        loadingPagination,
      ];

  SuppliersProformasListLoaded copyWith({
    List<SupplierProformaEntity>? proformasList,
    PaginationFilterDTO? paginationFilterDTO,
    int? totalCount,
    bool? loading,
    Option<Either<Failure, String>>? failureOrSuccessOption,
    bool? loadingPagination,
  }) {
    return SuppliersProformasListLoaded(
      proformasList: proformasList ?? this.proformasList,
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

class SuppliersProformasListError extends SuppliersProformasListState {
  final Failure failure;

  const SuppliersProformasListError({required this.failure});

  @override
  List<Object> get props => [failure];
}
