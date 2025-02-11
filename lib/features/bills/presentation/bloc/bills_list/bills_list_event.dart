part of 'bills_list_bloc.dart';

sealed class BillsListEvent extends Equatable {
  const BillsListEvent();

  @override
  List<Object> get props => [];
}

class GetBillsListEvent extends BillsListEvent {}

class OnUpdatePaginationEvent extends BillsListEvent {
  final int pageNumber;
  const OnUpdatePaginationEvent({required this.pageNumber});

  @override
  List<Object> get props => [pageNumber];
}

class HandleFailureEvent extends BillsListEvent {}

class NextPageEvent extends BillsListEvent {}

class PreviousPageEvent extends BillsListEvent {}

class DeleteBillEvent extends BillsListEvent {
  final int billId;
  const DeleteBillEvent({required this.billId});

  @override
  List<Object> get props => [billId];
}

class SearchInputChangedEvent extends BillsListEvent {
  final String keyword;
  const SearchInputChangedEvent({required this.keyword});

  @override
  List<Object> get props => [keyword];
}

class AddedUpdatedBillEvent extends BillsListEvent {}

class LoadMoreBillsEvent extends BillsListEvent {}

class GetBillsSummaryEvent extends BillsListEvent {}

class ApplyFilter extends BillsListEvent {
  final BillsFilterDto filterDto;
  const ApplyFilter({required this.filterDto});
}

class ResetFilter extends BillsListEvent {}
