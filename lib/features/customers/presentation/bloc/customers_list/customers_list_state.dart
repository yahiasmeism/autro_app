part of 'customers_list_bloc.dart';

sealed class CustomersListState extends Equatable {
  const CustomersListState();

  @override
  List<Object> get props => [];
}

final class CustomersListInitial extends CustomersListState {}

final class CustomersListLoaded extends CustomersListState {
  final List<CustomerEntity> customersList;
  final PaginationFilterDTO paginationFilterDTO;
  final int totalCount;
  final bool loading;
  final Option<Either<Failure, String>> failureOrSuccessOption;
  const CustomersListLoaded({
    required this.customersList,
    required this.totalCount,
    required this.paginationFilterDTO,
    this.loading = false,
    this.failureOrSuccessOption = const None(),
  });
  @override
  List<Object> get props => [
        customersList,
        paginationFilterDTO,
        totalCount,
        loading,
        failureOrSuccessOption,
      ];

  CustomersListLoaded copyWith({
    List<CustomerEntity>? customersList,
    PaginationFilterDTO? paginationFilterDTO,
    int? totalCount,
    bool? loading,
    Option<Either<Failure, String>>? failureOrSuccessOption,
  }) {
    return CustomersListLoaded(
      customersList: customersList ?? this.customersList,
      paginationFilterDTO: paginationFilterDTO ?? this.paginationFilterDTO,
      totalCount: totalCount ?? this.totalCount,
      loading: loading ?? this.loading,
      failureOrSuccessOption: failureOrSuccessOption ?? none(),
    );
  }

  bool get canGoNextPage => paginationFilterDTO.pageNumber < totalCount / paginationFilterDTO.pageSize;
  bool get canGoPreviousPage => paginationFilterDTO.pageNumber > 1;
}

class CustomersListError extends CustomersListState {
  final Failure failure;

  const CustomersListError({required this.failure});

  @override
  List<Object> get props => [failure];
}
