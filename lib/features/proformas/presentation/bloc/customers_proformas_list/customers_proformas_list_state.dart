part of 'customers_proformas_list_bloc.dart';

sealed class CustomersProformasListState extends Equatable {
  const CustomersProformasListState();

  @override
  List<Object> get props => [];
}

final class CustomersProformasListInitial extends CustomersProformasListState {}

final class CustomersProformasListLoaded extends CustomersProformasListState {
  final List<CustomerProformaEntity> proformasList;
  final PaginationFilterDTO paginationFilterDTO;
  final int totalCount;
  final bool loading;
  final bool loadingPagination;
  final Option<Either<Failure, String>> failureOrSuccessOption;
  const CustomersProformasListLoaded({
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

  CustomersProformasListLoaded copyWith({
    List<CustomerProformaEntity>? proformasList,
    PaginationFilterDTO? paginationFilterDTO,
    int? totalCount,
    bool? loading,
    Option<Either<Failure, String>>? failureOrSuccessOption,
    bool? loadingPagination,
  }) {
    return CustomersProformasListLoaded(
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

class CustomersProformasListError extends CustomersProformasListState {
  final Failure failure;

  const CustomersProformasListError({required this.failure});

  @override
  List<Object> get props => [failure];
}
