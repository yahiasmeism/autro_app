part of 'customers_proformas_list_bloc.dart';

sealed class ProformasListEvent extends Equatable {
  const ProformasListEvent();

  @override
  List<Object> get props => [];
}

class GetProformasListEvent extends ProformasListEvent {}

class OnUpdatePaginationEvent extends ProformasListEvent {
  final int pageNumber;
  const OnUpdatePaginationEvent({required this.pageNumber});

  @override
  List<Object> get props => [pageNumber];
}

class HandleFailureEvent extends ProformasListEvent {}

class NextPageEvent extends ProformasListEvent {}

class PreviousPageEvent extends ProformasListEvent {}

class DeleteProformaEvent extends ProformasListEvent {
  final BuildContext context;
  final int proformaId;
  const DeleteProformaEvent({required this.proformaId, required this.context});

  @override
  List<Object> get props => [proformaId, context];
}

class SearchInputChangedEvent extends ProformasListEvent {
  final String keyword;
  const SearchInputChangedEvent({required this.keyword});

  @override
  List<Object> get props => [keyword];
}

class AddedUpdatedProformaEvent extends ProformasListEvent {}

class LoadMoreProformasEvent extends ProformasListEvent {}
