part of 'customers_invoices_list_bloc.dart';

sealed class CustomersInvoicesListEvent extends Equatable {
  const CustomersInvoicesListEvent();

  @override
  List<Object> get props => [];
}

class GetCustomersInvoicesListEvent extends CustomersInvoicesListEvent {}

class OnUpdatePaginationEvent extends CustomersInvoicesListEvent {
  final int pageNumber;
  const OnUpdatePaginationEvent({required this.pageNumber});

  @override
  List<Object> get props => [pageNumber];
}

class HandleFailureEvent extends CustomersInvoicesListEvent {}

class NextPageEvent extends CustomersInvoicesListEvent {}

class PreviousPageEvent extends CustomersInvoicesListEvent {}

class DeleteInvoiceEvent extends CustomersInvoicesListEvent {
  final BuildContext context;
  final int invoiceId;
  const DeleteInvoiceEvent({required this.invoiceId, required this.context});

  @override
  List<Object> get props => [invoiceId];
}

class SearchInputChangedEvent extends CustomersInvoicesListEvent {
  final String keyword;
  const SearchInputChangedEvent({required this.keyword});

  @override
  List<Object> get props => [keyword];
}

class AddedUpdatedCustomersInvoiceEvent extends CustomersInvoicesListEvent {}

class LoadMoreCustomersInvoicesEvent extends CustomersInvoicesListEvent {}
