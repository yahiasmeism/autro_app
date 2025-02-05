part of 'suppliers_invoices_list_bloc.dart';

sealed class SuppliersInvoicesListEvent extends Equatable {
  const SuppliersInvoicesListEvent();

  @override
  List<Object> get props => [];
}

class GetSuppliersInvoicesListEvent extends SuppliersInvoicesListEvent {}

class OnUpdatePaginationEvent extends SuppliersInvoicesListEvent {
  final int pageNumber;
  const OnUpdatePaginationEvent({required this.pageNumber});

  @override
  List<Object> get props => [pageNumber];
}

class HandleFailureEvent extends SuppliersInvoicesListEvent {}

class NextPageEvent extends SuppliersInvoicesListEvent {}

class PreviousPageEvent extends SuppliersInvoicesListEvent {}

class DeleteInvoiceEvent extends SuppliersInvoicesListEvent {
  final BuildContext context;
  final int invoiceId;
  const DeleteInvoiceEvent({required this.invoiceId, required this.context});

  @override
  List<Object> get props => [invoiceId];
}

class SearchInputChangedEvent extends SuppliersInvoicesListEvent {
  final String keyword;
  const SearchInputChangedEvent({required this.keyword});

  @override
  List<Object> get props => [keyword];
}

class AddedUpdatedSuppliersInvoiceEvent extends SuppliersInvoicesListEvent {}

class LoadMoreSuppliersInvoicesEvent extends SuppliersInvoicesListEvent {}
