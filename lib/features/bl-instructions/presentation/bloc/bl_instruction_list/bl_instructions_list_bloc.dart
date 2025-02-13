import 'package:autro_app/core/errors/failures.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/common/domin/dto/pagination_query_payload_dto.dart';
import '../../../domin/entities/bl_insturction_entity.dart';
import '../../../domin/repositories/bl_instructions_repo.dart';
import '../../../domin/usecases/create_bl_instruction_use_case.dart';
import '../../../domin/usecases/delete_bl_instruction_use_case.dart';
import '../../../domin/usecases/get_bl_instruction_list_use_case.dart';
import '../../../domin/usecases/update_bl_instruction_use_case.dart';

part 'bl_instructions_list_state.dart';
part 'bl_instructions_list_event.dart';

@injectable
class BlInstructionsListBloc extends Bloc<BlInstructionsListEvent, BlInstructionsListState> {
  final GetBlInsturctionsListUseCase getBlInstructionsListUsecase;
  final DeleteBlInsturctionUseCase deleteBlInstructionUsecase;
  final BlInsturctionsRepository blInsturctionsRepository;
  final UpdateBlInsturctionsUseCase updateBlInstructionUsecase;
  final CreateBlInsturctionUseCase createBlInstructionUsecase;
  BlInstructionsListBloc(
    this.getBlInstructionsListUsecase,
    this.deleteBlInstructionUsecase,
    this.blInsturctionsRepository,
    this.updateBlInstructionUsecase,
    this.createBlInstructionUsecase,
  ) : super(BlInstructionsListInitial()) {
    on<BlInstructionsListEvent>(_mapEvents, transformer: (events, mapper) => events.asyncExpand(mapper));
  }

  int get totalCount => blInsturctionsRepository.blInsturctionsCount;

  Future _mapEvents(BlInstructionsListEvent event, Emitter<BlInstructionsListState> emit) async {
    if (event is GetBlInstructionsListEvent) {
      await onGetBlInstructionsList(event, emit);
    }

    if (event is OnUpdatePaginationBlInstructionsEvent) {
      await onUpdatePagination(event, emit);
    }

    if (event is HandleFailureBlInstructionsEvent) {
      await onHandleFailure(event, emit);
    }

    if (event is NextPageBlInstructionsEvent) {
      await onNextPage(event, emit);
    }
    if (event is PreviousPageBlInstructionsEvent) {
      await onPreviousPage(event, emit);
    }
    if (event is DeleteBlInstructionEvent) {
      await onDeleteBlInstruction(event, emit);
    }
    if (event is SearchInputChangedBlInstructionsEvent) {
      await onSearchInputChanged(event, emit);
    }
    if (event is AddedUpdatedBlInstructionEvent) {
      await onAddedUpdatedBlInstruction(event, emit);
    }
  }

  Future onGetBlInstructionsList(GetBlInstructionsListEvent event, Emitter<BlInstructionsListState> emit) async {
    emit(BlInstructionsListInitial());
    final paginationFilterDto = PaginationFilterDTO.initial();
    final params = GetBlInsturctionsListUseCaseParams(paginationFilterDTO: paginationFilterDto);
    final either = await getBlInstructionsListUsecase.call(params);
    either.fold(
      (failure) => emit(BlInstructionsListError(failure: failure)),
      (blInsturctions) => emit(BlInstructionsListLoaded(
        totalCount: totalCount,
        blInsturctionsList: blInsturctions,
        paginationFilterDTO: paginationFilterDto,
      )),
    );
  }

  Future onUpdatePagination(OnUpdatePaginationBlInstructionsEvent event, Emitter<BlInstructionsListState> emit) async {
    final state = this.state as BlInstructionsListLoaded;
    final paginationFilterDto = state.paginationFilterDTO.copyWith(pageNumber: event.pageNumber);
    final params = GetBlInsturctionsListUseCaseParams(paginationFilterDTO: paginationFilterDto);

    emit(state.copyWith(loadingPagination: true));
    final either = await getBlInstructionsListUsecase.call(params);
    emit(state.copyWith(loadingPagination: false));
    either.fold(
      (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
      (blInsturctions) => emit(state.copyWith(
        totalCount: totalCount,
        blInsturctionsList: blInsturctions,
        paginationFilterDTO: paginationFilterDto,
      )),
    );
  }

  onHandleFailure(HandleFailureBlInstructionsEvent event, Emitter<BlInstructionsListState> emit) async {
    emit(BlInstructionsListInitial());
    await Future.delayed(const Duration(milliseconds: 300));
    add(GetBlInstructionsListEvent());
  }

  onNextPage(NextPageBlInstructionsEvent event, Emitter<BlInstructionsListState> emit) {
    final state = this.state as BlInstructionsListLoaded;
    final pageNumber = state.paginationFilterDTO.pageNumber + 1;
    add(OnUpdatePaginationBlInstructionsEvent(pageNumber: pageNumber));
  }

  onPreviousPage(PreviousPageBlInstructionsEvent event, Emitter<BlInstructionsListState> emit) {
    final state = this.state as BlInstructionsListLoaded;
    final pageNumber = state.paginationFilterDTO.pageNumber - 1;
    add(OnUpdatePaginationBlInstructionsEvent(pageNumber: pageNumber));
  }

  onDeleteBlInstruction(DeleteBlInstructionEvent event, Emitter<BlInstructionsListState> emit) async {
    final state = this.state as BlInstructionsListLoaded;
    emit(state.copyWith(loading: true));
    final either = await deleteBlInstructionUsecase.call(event.blInsturctionId);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
      (_) {
        final updatedBlInstructionsList = List.of(state.blInsturctionsList);
        updatedBlInstructionsList.removeWhere((element) => element.id == event.blInsturctionId);
        const message = 'BL Instruction Deleted Successfully';
        emit(state.copyWith(
          blInsturctionsList: updatedBlInstructionsList,
          failureOrSuccessOption: some(right(message)),
          totalCount: totalCount - 1,
        ));
      },
    );
  }

  onSearchInputChanged(SearchInputChangedBlInstructionsEvent event, Emitter<BlInstructionsListState> emit) async {
    if (state is BlInstructionsListLoaded) {
      final state = this.state as BlInstructionsListLoaded;

      emit(state.copyWith(loading: true));

      final conditions = List.of(state.paginationFilterDTO.filter.conditions);

      final newCondition = FilterConditionDTO.searchFilter(event.keyword);

      conditions.removeWhere((condition) => condition.fieldName == newCondition.fieldName);
      if (event.keyword.isNotEmpty) conditions.add(newCondition);

      final updatedFilter = state.paginationFilterDTO.filter.copyWith(conditions: conditions);

      final updatedFilterPagination = PaginationFilterDTO.initial().copyWith(filter: updatedFilter);

      final params = GetBlInsturctionsListUseCaseParams(paginationFilterDTO: updatedFilterPagination);

      final either = await getBlInstructionsListUsecase.call(params);
      emit(state.copyWith(loading: false));

      either.fold(
        (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
        (blInsturctions) {
          emit(state.copyWith(
            blInsturctionsList: blInsturctions,
            paginationFilterDTO: updatedFilterPagination,
            totalCount: totalCount,
          ));
        },
      );
    }
  }

  onAddedUpdatedBlInstruction(AddedUpdatedBlInstructionEvent event, Emitter<BlInstructionsListState> emit) async {
    final state = this.state as BlInstructionsListLoaded;
    final params = GetBlInsturctionsListUseCaseParams(paginationFilterDTO: state.paginationFilterDTO);
    emit(state.copyWith(loading: true));
    final either = await getBlInstructionsListUsecase.call(params);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
      (blInsturctions) => emit(state.copyWith(
        totalCount: totalCount,
        blInsturctionsList: blInsturctions,
      )),
    );
  }
}
