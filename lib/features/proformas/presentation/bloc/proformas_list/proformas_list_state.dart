part of 'proformas_list_bloc.dart';

sealed class ProformasListState extends Equatable {
  const ProformasListState();

  @override
  List<Object> get props => [];
}

final class ProformasListInitial extends ProformasListState {}

final class ProformasListLoaded extends ProformasListState {
  final List<ProformaEntity> proformasList;
  final PaginationFilterDTO paginationFilterDTO;
  final int totalCount;
  final bool loading;
  final bool loadingPagination;
  final Option<Either<Failure, String>> failureOrSuccessOption;
  const ProformasListLoaded({
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

  ProformasListLoaded copyWith({
    List<ProformaEntity>? proformasList,
    PaginationFilterDTO? paginationFilterDTO,
    int? totalCount,
    bool? loading,
    Option<Either<Failure, String>>? failureOrSuccessOption,
    bool? loadingPagination,
  }) {
    return ProformasListLoaded(
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

class ProformasListError extends ProformasListState {
  final Failure failure;

  const ProformasListError({required this.failure});

  @override
  List<Object> get props => [failure];
}
