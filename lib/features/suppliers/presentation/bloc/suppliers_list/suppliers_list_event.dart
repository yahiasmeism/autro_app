part of 'suppliers_list_bloc.dart';

sealed class SuppliersListEvent extends Equatable {
  const SuppliersListEvent();

  @override
  List<Object> get props => [];
}

class GetSuppliersListEvent extends SuppliersListEvent {}

class OnUpdatePaginationSuppliersEvent extends SuppliersListEvent {
  final int pageNumber;
  const OnUpdatePaginationSuppliersEvent({required this.pageNumber});

  @override
  List<Object> get props => [pageNumber];
}

class HandleFailureSuppliersEvent extends SuppliersListEvent {}

class NextPageSuppliersEvent extends SuppliersListEvent {}

class PreviousPageSuppliersEvent extends SuppliersListEvent {}

class DeleteSupplierEvent extends SuppliersListEvent {
  final int supplierId;
  const DeleteSupplierEvent({required this.supplierId});

  @override
  List<Object> get props => [supplierId];
}

class SearchInputChangedSuppliersEvent extends SuppliersListEvent {
  final String keyword;
  const SearchInputChangedSuppliersEvent({required this.keyword});

  @override
  List<Object> get props => [keyword];
}

class AddedUpdatedSupplierEvent extends SuppliersListEvent {}


class LoadMoreSuppliersEvent extends SuppliersListEvent {}