part of 'suppliers_proformas_list_bloc.dart';

sealed class SuppliersProformasListEvent extends Equatable {
  const SuppliersProformasListEvent();

  @override
  List<Object> get props => [];
}

class GetSuppliersProformasListEvent extends SuppliersProformasListEvent {}

class OnUpdatePaginationEvent extends SuppliersProformasListEvent {
  final int pageNumber;
  const OnUpdatePaginationEvent({required this.pageNumber});

  @override
  List<Object> get props => [pageNumber];
}

class HandleFailureEvent extends SuppliersProformasListEvent {}

class NextPageEvent extends SuppliersProformasListEvent {}

class PreviousPageEvent extends SuppliersProformasListEvent {}

class DeleteProformaEvent extends SuppliersProformasListEvent {
  final BuildContext context;
  final int proformaId;
  const DeleteProformaEvent({required this.proformaId, required this.context});

  @override
  List<Object> get props => [proformaId];
}

class SearchInputChangedEvent extends SuppliersProformasListEvent {
  final String keyword;
  const SearchInputChangedEvent({required this.keyword});

  @override
  List<Object> get props => [keyword];
}

class AddedUpdatedSuppliersProformaEvent extends SuppliersProformasListEvent {}

class LoadMoreSuppliersProformasEvent extends SuppliersProformasListEvent {}
