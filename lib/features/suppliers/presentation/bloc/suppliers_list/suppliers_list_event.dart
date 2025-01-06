part of 'suppliers_list_bloc.dart';

sealed class SuppliersListEvent extends Equatable {
  const SuppliersListEvent();

  @override
  List<Object> get props => [];
}

class GetSuppliersListEvent extends SuppliersListEvent {}

class OnUpdatePaginationEvent extends SuppliersListEvent {
  final int pageNumber;
  const OnUpdatePaginationEvent({required this.pageNumber});

  @override
  List<Object> get props => [pageNumber];
}

class HandleFailureEvent extends SuppliersListEvent {}

class NextPageEvent extends SuppliersListEvent {}

class PreviousPageEvent extends SuppliersListEvent {}

class DeleteSupplierEvent extends SuppliersListEvent {
  final int supplierId;
  const DeleteSupplierEvent({required this.supplierId});

  @override
  List<Object> get props => [supplierId];
}

class SearchInputChangedEvent extends SuppliersListEvent {
  final String keyword;
  const SearchInputChangedEvent({required this.keyword});

  @override
  List<Object> get props => [keyword];
}

class AddedUpdatedSupplierEvent extends SuppliersListEvent {}
