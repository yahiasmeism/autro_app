part of 'deals_list_bloc.dart';

sealed class DealsListEvent extends Equatable {
  const DealsListEvent();

  @override
  List<Object> get props => [];
}

class GetDealsListEvent extends DealsListEvent {
  final FilterDTO? filterDTO;

  const GetDealsListEvent({this.filterDTO});
}

class OnUpdatePaginationEvent extends DealsListEvent {
  final int pageNumber;
  const OnUpdatePaginationEvent({required this.pageNumber});

  @override
  List<Object> get props => [pageNumber];
}

class HandleFailureEvent extends DealsListEvent {}

class NextPageEvent extends DealsListEvent {}

class PreviousPageEvent extends DealsListEvent {}

class DeleteDealEvent extends DealsListEvent {
  final BuildContext context;
  final int dealId;
  const DeleteDealEvent({required this.dealId, required this.context});

  @override
  List<Object> get props => [dealId];
}

class ApplyFilterEvent extends DealsListEvent {
  final FilterDTO filterDto;

  const ApplyFilterEvent({required this.filterDto});
}

class SearchInputChangedEvent extends DealsListEvent {
  final String keyword;
  const SearchInputChangedEvent({required this.keyword});

  @override
  List<Object> get props => [keyword];
}

class AddedUpdatedDealEvent extends DealsListEvent {}

class LoadMoreDealsEvent extends DealsListEvent {}

class CreateDealEvent extends DealsListEvent {
  final int customerProformaId;

  const CreateDealEvent({required this.customerProformaId});

  @override
  List<Object> get props => [customerProformaId];
}
