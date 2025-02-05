part of 'deal_bills_list_bloc.dart';

sealed class DealBillsListEvent extends Equatable {
  const DealBillsListEvent();

  @override
  List<Object> get props => [];
}

class GetDealBillsListEvent extends DealBillsListEvent {
  final int dealId;
  const GetDealBillsListEvent({required this.dealId});

  @override
  List<Object> get props => [dealId];
}

class OnUpdatePaginationDealBillsEvent extends DealBillsListEvent {
  final int pageNumber;
  const OnUpdatePaginationDealBillsEvent({required this.pageNumber});

  @override
  List<Object> get props => [pageNumber];
}

class HandleFailureDealBillsEvent extends DealBillsListEvent {}

class NextPageDealBillsEvent extends DealBillsListEvent {}

class PreviousPageDealBillsEvent extends DealBillsListEvent {}

class DeleteDealBillEvent extends DealBillsListEvent {
  final BuildContext context;
  final int dealBillId;
  const DeleteDealBillEvent({required this.dealBillId, required this.context});

  @override
  List<Object> get props => [dealBillId];
}

class SearchInputChangedDealBillsEvent extends DealBillsListEvent {
  final String keyword;
  const SearchInputChangedDealBillsEvent({required this.keyword});

  @override
  List<Object> get props => [keyword];
}

class AddedUpdatedDealBillEvent extends DealBillsListEvent {}
