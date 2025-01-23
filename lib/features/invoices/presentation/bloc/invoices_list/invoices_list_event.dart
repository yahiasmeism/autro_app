part of 'invoices_list_bloc.dart';

sealed class InvoicesListEvent extends Equatable {
  const InvoicesListEvent();

  @override
  List<Object> get props => [];
}

class GetInvoicesListEvent extends InvoicesListEvent {}

class OnUpdatePaginationEvent extends InvoicesListEvent {
  final int pageNumber;
  const OnUpdatePaginationEvent({required this.pageNumber});

  @override
  List<Object> get props => [pageNumber];
}

class HandleFailureEvent extends InvoicesListEvent {}

class NextPageEvent extends InvoicesListEvent {}

class PreviousPageEvent extends InvoicesListEvent {}

class DeleteInvoiceEvent extends InvoicesListEvent {
  final int invoiceId;
  const DeleteInvoiceEvent({required this.invoiceId});

  @override
  List<Object> get props => [invoiceId];
}

class SearchInputChangedEvent extends InvoicesListEvent {
  final String keyword;
  const SearchInputChangedEvent({required this.keyword});

  @override
  List<Object> get props => [keyword];
}

class AddedUpdatedInvoiceEvent extends InvoicesListEvent {}
