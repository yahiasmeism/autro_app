part of 'packing_lists_bloc.dart';

sealed class PackingListsEvent extends Equatable {
  const PackingListsEvent();

  @override
  List<Object> get props => [];
}

class GetPackingListsEvent extends PackingListsEvent {}

class OnUpdatePaginationEvent extends PackingListsEvent {
  final int pageNumber;
  const OnUpdatePaginationEvent({required this.pageNumber});

  @override
  List<Object> get props => [pageNumber];
}

class HandleFailureEvent extends PackingListsEvent {}

class NextPageEvent extends PackingListsEvent {}

class PreviousPageEvent extends PackingListsEvent {}

class DeletePackingListEvent extends PackingListsEvent {
  final int packingListId;
  const DeletePackingListEvent({required this.packingListId});

  @override
  List<Object> get props => [packingListId];
}

class SearchInputChangedEvent extends PackingListsEvent {
  final String keyword;
  const SearchInputChangedEvent({required this.keyword});

  @override
  List<Object> get props => [keyword];
}

class AddedUpdatedPackingListEvent extends PackingListsEvent {}

class LoadMorePackingListsEvent extends PackingListsEvent {}
