part of 'shipping_invoices_list_bloc.dart';

sealed class ShippingInvoicesListEvent extends Equatable {
  const ShippingInvoicesListEvent();

  @override
  List<Object> get props => [];
}

class GetShippingInvoicesListEvent extends ShippingInvoicesListEvent {}

class OnUpdatePaginationShippingInvoicesEvent extends ShippingInvoicesListEvent {
  final int pageNumber;
  const OnUpdatePaginationShippingInvoicesEvent({required this.pageNumber});

  @override
  List<Object> get props => [pageNumber];
}

class HandleFailureShippingInvoicesEvent extends ShippingInvoicesListEvent {}

class NextPageShippingInvoicesEvent extends ShippingInvoicesListEvent {}

class PreviousPageShippingInvoicesEvent extends ShippingInvoicesListEvent {}

class DeleteShippingInvoiceEvent extends ShippingInvoicesListEvent {
  final int shippingInvoiceId;
  const DeleteShippingInvoiceEvent({required this.shippingInvoiceId});

  @override
  List<Object> get props => [shippingInvoiceId];
}

class SearchInputChangedShippingInvoicesEvent extends ShippingInvoicesListEvent {
  final String keyword;
  const SearchInputChangedShippingInvoicesEvent({required this.keyword});

  @override
  List<Object> get props => [keyword];
}

class AddedUpdatedShippingInvoiceEvent extends ShippingInvoicesListEvent {}
