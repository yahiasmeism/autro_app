import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/features/packing-lists/domin/entities/packing_list_entity.dart';
import 'package:autro_app/features/packing-lists/domin/use_cases/create_packing_list_use_case.dart';
import 'package:autro_app/features/packing-lists/domin/use_cases/get_all_packing_lists_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/common/domin/dto/pagination_query_payload_dto.dart';
import '../../../domin/reposetories/packing_lists_repository.dart';
import '../../../domin/use_cases/delete_packing_list_use_case.dart';
import '../../../domin/use_cases/update_packing_list_use_case.dart';

part 'packing_lists_event.dart';
part 'packing_lists_state.dart';

@injectable
class PackingListsBloc extends Bloc<PackingListsEvent, PackingListsState> {
  final GetAllPackingListsUseCase getAllPackingListsUsecase;
  final DeletePackingListUseCase deletePackingListUsecase;
  final PackingListsRepository packingListsRepository;
  final GetAllPackingListsUseCase getPackingListsSummaryUsecase;
  final UpdatePackingListUseCase updatePackingListUsecase;
  final CreatePackingListUseCase createPackingListUsecase;
  PackingListsBloc(
    this.getAllPackingListsUsecase,
    this.packingListsRepository,
    this.deletePackingListUsecase,
    this.updatePackingListUsecase,
    this.createPackingListUsecase,
    this.getPackingListsSummaryUsecase,
  ) : super(PackingListsInitial()) {
    on<PackingListsEvent>(_mapEvents, transformer: (events, mapper) => events.asyncExpand(mapper));
  }

  int get packingListsCount => packingListsRepository.totalCount;

  Future _mapEvents(PackingListsEvent event, Emitter<PackingListsState> emit) async {
    if (event is GetPackingListsEvent) {
      await onGetPackingLists(event, emit);
    }

    if (event is OnUpdatePaginationEvent) {
      await onUpdatePagination(event, emit);
    }

    if (event is HandleFailureEvent) {
      await onHandleFailure(event, emit);
    }

    if (event is NextPageEvent) {
      await onNextPage(event, emit);
    }
    if (event is PreviousPageEvent) {
      await onPreviousPage(event, emit);
    }
    if (event is DeletePackingListEvent) {
      await onDeletePackingList(event, emit);
    }
    if (event is SearchInputChangedEvent) {
      await onSearchInputChanged(event, emit);
    }
    if (event is AddedUpdatedPackingListEvent) {
      await onAddedUpdatedPackingList(event, emit);
    }

    if (event is LoadMorePackingListsEvent) {
      await onLoadMorePackingLists(event, emit);
    }
  }

  Future onGetPackingLists(GetPackingListsEvent event, Emitter<PackingListsState> emit) async {
    emit(PackingListsInitial());
    final paginationFilterDto = PaginationFilterDTO.initial();
    final params = GetAllPackingListsUseCaseParams(paginationFilterDTO: paginationFilterDto);
    final either = await getAllPackingListsUsecase.call(params);
    either.fold(
      (failure) => emit(PackingListsError(failure: failure)),
      (packingLists) {
        emit(PackingListsLoaded(
          totalCount: packingListsCount,
          packingLists: packingLists,
          paginationFilterDTO: paginationFilterDto,
        ));
      },
    );
  }

  Future onUpdatePagination(OnUpdatePaginationEvent event, Emitter<PackingListsState> emit) async {
    final state = this.state as PackingListsLoaded;
    final paginationFilterDto = state.paginationFilterDTO.copyWith(pageNumber: event.pageNumber);
    final params = GetAllPackingListsUseCaseParams(paginationFilterDTO: paginationFilterDto);

    emit(state.copyWith(loadingPagination: true));
    final either = await getAllPackingListsUsecase.call(params);
    emit(state.copyWith(loadingPagination: false));
    either.fold(
      (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
      (packingLists) => emit(state.copyWith(
        totalCount: packingListsCount,
        packingLists: packingLists,
        paginationFilterDTO: paginationFilterDto,
      )),
    );
  }

  onHandleFailure(HandleFailureEvent event, Emitter<PackingListsState> emit) async {
    emit(PackingListsInitial());
    await Future.delayed(const Duration(milliseconds: 300));
    add(GetPackingListsEvent());
  }

  onNextPage(NextPageEvent event, Emitter<PackingListsState> emit) {
    final state = this.state as PackingListsLoaded;
    final pageNumber = state.paginationFilterDTO.pageNumber + 1;
    add(OnUpdatePaginationEvent(pageNumber: pageNumber));
  }

  onPreviousPage(PreviousPageEvent event, Emitter<PackingListsState> emit) {
    final state = this.state as PackingListsLoaded;
    final pageNumber = state.paginationFilterDTO.pageNumber - 1;
    add(OnUpdatePaginationEvent(pageNumber: pageNumber));
  }

  onDeletePackingList(DeletePackingListEvent event, Emitter<PackingListsState> emit) async {
    final state = this.state as PackingListsLoaded;
    emit(state.copyWith(loading: true));
    final either = await deletePackingListUsecase.call(event.packingListId);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
      (_) {
        final updatedPackingLists = List.of(state.packingLists);
        updatedPackingLists.removeWhere((element) => element.id == event.packingListId);
        const message = 'PackingList Deleted Successfully';
        emit(state.copyWith(
          packingLists: updatedPackingLists,
          failureOrSuccessOption: some(right(message)),
          totalCount: packingListsCount - 1,
        ));
      },
    );
  }

  onSearchInputChanged(SearchInputChangedEvent event, Emitter<PackingListsState> emit) async {
    if (state is PackingListsLoaded) {
      final state = this.state as PackingListsLoaded;

      emit(state.copyWith(loading: true));

      final conditions = List.of(state.paginationFilterDTO.filter.conditions);

      final newCondition = FilterConditionDTO.searchFilter(event.keyword);

      conditions.removeWhere((condition) => condition.fieldName == newCondition.fieldName);
      if (event.keyword.isNotEmpty) conditions.add(newCondition);

      final updatedFilter = state.paginationFilterDTO.filter.copyWith(conditions: conditions);

      final updatedFilterPagination = PaginationFilterDTO.initial().copyWith(filter: updatedFilter);

      final params = GetAllPackingListsUseCaseParams(paginationFilterDTO: updatedFilterPagination);

      final either = await getAllPackingListsUsecase.call(params);
      emit(state.copyWith(loading: false));

      either.fold(
        (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
        (packingLists) {
          emit(state.copyWith(
            packingLists: packingLists,
            paginationFilterDTO: updatedFilterPagination,
            totalCount: packingListsCount,
          ));
        },
      );
    }
  }

  onAddedUpdatedPackingList(AddedUpdatedPackingListEvent event, Emitter<PackingListsState> emit) async {
    final state = this.state as PackingListsLoaded;
    final params = GetAllPackingListsUseCaseParams(paginationFilterDTO: state.paginationFilterDTO);
    emit(state.copyWith(loading: true));
    final either = await getAllPackingListsUsecase.call(params);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
      (packingLists) {
        emit(state.copyWith(
          totalCount: packingListsCount,
          packingLists: packingLists,
        ));
      },
    );
  }

  onLoadMorePackingLists(LoadMorePackingListsEvent event, Emitter<PackingListsState> emit) async {
    final state = this.state as PackingListsLoaded;

    final pageNumber = state.paginationFilterDTO.pageNumber + 1;

    if (pageNumber > state.totalPages) return;
    emit(state.copyWith(loadingPagination: true));
    final paginationFilterDto = state.paginationFilterDTO.copyWith(pageNumber: pageNumber);
    final params = GetAllPackingListsUseCaseParams(paginationFilterDTO: paginationFilterDto);

    final either = await getAllPackingListsUsecase.call(params);
    emit(state.copyWith(loadingPagination: false));
    either.fold(
      (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
      (packingLists) {
        final updatedPackingLists = List.of(state.packingLists);
        updatedPackingLists.addAll(packingLists);
        emit(state.copyWith(
          totalCount: packingListsCount,
          packingLists: updatedPackingLists,
          paginationFilterDTO: paginationFilterDto,
        ));
      },
    );
  }
}
