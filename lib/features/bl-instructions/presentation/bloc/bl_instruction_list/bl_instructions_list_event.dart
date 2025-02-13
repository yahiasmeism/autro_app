part of 'bl_instructions_list_bloc.dart';

sealed class BlInstructionsListEvent extends Equatable {
  const BlInstructionsListEvent();

  @override
  List<Object> get props => [];
}

class GetBlInstructionsListEvent extends BlInstructionsListEvent {}

class OnUpdatePaginationBlInstructionsEvent extends BlInstructionsListEvent {
  final int pageNumber;
  const OnUpdatePaginationBlInstructionsEvent({required this.pageNumber});

  @override
  List<Object> get props => [pageNumber];
}

class HandleFailureBlInstructionsEvent extends BlInstructionsListEvent {}

class NextPageBlInstructionsEvent extends BlInstructionsListEvent {}

class PreviousPageBlInstructionsEvent extends BlInstructionsListEvent {}

class DeleteBlInstructionEvent extends BlInstructionsListEvent {
  final int blInsturctionId;
  const DeleteBlInstructionEvent({required this.blInsturctionId});

  @override
  List<Object> get props => [blInsturctionId];
}

class SearchInputChangedBlInstructionsEvent extends BlInstructionsListEvent {
  final String keyword;
  const SearchInputChangedBlInstructionsEvent({required this.keyword});

  @override
  List<Object> get props => [keyword];
}

class AddedUpdatedBlInstructionEvent extends BlInstructionsListEvent {}
