part of 'customers_list_bloc.dart';

sealed class CustomersListEvent extends Equatable {
  const CustomersListEvent();

  @override
  List<Object> get props => [];
}

class GetCustomersListEvent extends CustomersListEvent {}

class OnUpdatePaginationEvent extends CustomersListEvent {
  final int pageNumber;
  const OnUpdatePaginationEvent({required this.pageNumber});

  @override
  List<Object> get props => [pageNumber];
}

class HandleFailureEvent extends CustomersListEvent {}

class NextPageEvent extends CustomersListEvent {}

class PreviousPageEvent extends CustomersListEvent {}

class DeleteCustomerEvent extends CustomersListEvent {
  final int customerId;
  const DeleteCustomerEvent({required this.customerId});

  @override
  List<Object> get props => [customerId];
}

class SearchInputChangedEvent extends CustomersListEvent {
  final String keyword;
  const SearchInputChangedEvent({required this.keyword});

  @override
  List<Object> get props => [keyword];
}

class AddedUpdatedCustomerEvent extends CustomersListEvent {}
