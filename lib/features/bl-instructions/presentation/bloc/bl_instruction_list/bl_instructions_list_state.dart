part of 'bl_instructions_list_bloc.dart';

sealed class BlInstructionsListState extends Equatable {
  const BlInstructionsListState();

  @override
  List<Object> get props => [];
}

final class BlInstructionsListInitial extends BlInstructionsListState {}

final class BlInstructionsListLoaded extends BlInstructionsListState {
  final PaginationFilterDTO paginationFilterDTO;
  final List<BlInsturctionEntity> blInsturctionsList;
  final int totalCount;
  final bool loading;
  final bool loadingPagination;
  final Option<Either<Failure, String>> failureOrSuccessOption;
  const BlInstructionsListLoaded({
    required this.blInsturctionsList,
    required this.totalCount,
    required this.paginationFilterDTO,
    this.loading = false,
    this.loadingPagination = false,
    this.failureOrSuccessOption = const None(),
  });
  @override
  List<Object> get props => [
        blInsturctionsList,
        paginationFilterDTO,
        totalCount,
        loading,
        failureOrSuccessOption,
        loadingPagination,
      ];

  BlInstructionsListLoaded copyWith({
    List<BlInsturctionEntity>? blInsturctionsList,
    PaginationFilterDTO? paginationFilterDTO,
    int? totalCount,
    bool? loading,
    Option<Either<Failure, String>>? failureOrSuccessOption,
    bool? loadingPagination,
  }) {
    return BlInstructionsListLoaded(
      blInsturctionsList: blInsturctionsList ?? this.blInsturctionsList,
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

class BlInstructionsListError extends BlInstructionsListState {
  final Failure failure;

  const BlInstructionsListError({required this.failure});

  @override
  List<Object> get props => [failure];
}
