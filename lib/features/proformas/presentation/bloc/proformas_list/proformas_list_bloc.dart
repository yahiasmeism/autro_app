import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/features/proformas/domin/repositories/proformas_repository.dart';
import 'package:autro_app/features/proformas/domin/use_cases/delete_proforma_use_case.dart';
import 'package:autro_app/features/proformas/domin/use_cases/get_proformas_list_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/common/domin/dto/pagination_query_payload_dto.dart';
import '../../../domin/entities/proforma_entity.dart';
import '../../../domin/use_cases/create_proforma_use_case.dart';
import '../../../domin/use_cases/update_proforma_use_case.dart';

part 'proformas_list_event.dart';
part 'proformas_list_state.dart';

@injectable
class ProformasListBloc extends Bloc<ProformasListEvent, ProformasListState> {
  final GetProformasListUseCase getProformasListUsecase;
  final DeleteProformaUseCase deleteProformaUsecase;
  final ProformasRepository proformasRepository;
  final UpdateProformaUseCase updateProformaUsecase;
  final CreateProformaUseCase createProformaUsecase;
  ProformasListBloc(
    this.getProformasListUsecase,
    this.proformasRepository,
    this.deleteProformaUsecase,
    this.updateProformaUsecase,
    this.createProformaUsecase,
  ) : super(ProformasListInitial()) {
    on<ProformasListEvent>(_mapEvents);
  }

  int get totalCount => proformasRepository.totalCount;

  Future _mapEvents(ProformasListEvent event, Emitter<ProformasListState> emit) async {
    if (event is GetProformasListEvent) {
      await onGetProformasList(event, emit);
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
    if (event is DeleteProformaEvent) {
      await onDeleteProforma(event, emit);
    }
    if (event is SearchInputChangedEvent) {
      await onSearchInputChanged(event, emit);
    }
    if (event is AddedUpdatedProformaEvent) {
      await onAddedUpdatedProforma(event, emit);
    }
    if (event is LoadMoreProformasEvent) {
      await onLoadMoreProformas(event, emit);
    }
  }

  Future onGetProformasList(GetProformasListEvent event, Emitter<ProformasListState> emit) async {
    emit(ProformasListInitial());
    final paginationFilterDto = PaginationFilterDTO.initial();
    final params = GetProformasListUseCaseParams(dto: paginationFilterDto);
    final either = await getProformasListUsecase.call(params);
    either.fold(
      (failure) => emit(ProformasListError(failure: failure)),
      (proformas) => emit(ProformasListLoaded(
        totalCount: totalCount,
        proformasList: proformas,
        paginationFilterDTO: paginationFilterDto,
      )),
    );
  }

  Future onUpdatePagination(OnUpdatePaginationEvent event, Emitter<ProformasListState> emit) async {
    final state = this.state as ProformasListLoaded;
    final paginationFilterDto = state.paginationFilterDTO.copyWith(pageNumber: event.pageNumber);
    final params = GetProformasListUseCaseParams(dto: paginationFilterDto);

    emit(state.copyWith(loadingPagination: true));
    final either = await getProformasListUsecase.call(params);
    emit(state.copyWith(loadingPagination: false));
    either.fold(
      (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
      (proformas) => emit(state.copyWith(
        totalCount: totalCount,
        proformasList: proformas,
        paginationFilterDTO: paginationFilterDto,
      )),
    );
  }

  onHandleFailure(HandleFailureEvent event, Emitter<ProformasListState> emit) async {
    emit(ProformasListInitial());
    await Future.delayed(const Duration(milliseconds: 300));
    add(GetProformasListEvent());
  }

  onNextPage(NextPageEvent event, Emitter<ProformasListState> emit) {
    final state = this.state as ProformasListLoaded;
    final pageNumber = state.paginationFilterDTO.pageNumber + 1;
    add(OnUpdatePaginationEvent(pageNumber: pageNumber));
  }

  onPreviousPage(PreviousPageEvent event, Emitter<ProformasListState> emit) {
    final state = this.state as ProformasListLoaded;
    final pageNumber = state.paginationFilterDTO.pageNumber - 1;
    add(OnUpdatePaginationEvent(pageNumber: pageNumber));
  }

  onDeleteProforma(DeleteProformaEvent event, Emitter<ProformasListState> emit) async {
    final state = this.state as ProformasListLoaded;
    emit(state.copyWith(loading: true));
    final either = await deleteProformaUsecase.call(event.proformaId);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
      (_) {
        final updatedProformasList = List.of(state.proformasList);
        updatedProformasList.removeWhere((element) => element.id == event.proformaId);
        const message = 'Proforma Deleted Successfully';
        emit(state.copyWith(
          proformasList: updatedProformasList,
          failureOrSuccessOption: some(right(message)),
          totalCount: totalCount - 1,
        ));
      },
    );
  }

  onSearchInputChanged(SearchInputChangedEvent event, Emitter<ProformasListState> emit) async {
    final state = this.state as ProformasListLoaded;

    emit(state.copyWith(loading: true));

    final conditions = List.of(state.paginationFilterDTO.filter.conditions);

    final newCondition = FilterConditionDTO.searchFilter(event.keyword);

    conditions.removeWhere((condition) => condition.fieldName == newCondition.fieldName);
    if (event.keyword.isNotEmpty) conditions.add(newCondition);

    final updatedFilter = state.paginationFilterDTO.filter.copyWith(conditions: conditions);

    final updatedFilterPagination = PaginationFilterDTO.initial().copyWith(filter: updatedFilter);

    final params = GetProformasListUseCaseParams(dto: updatedFilterPagination);

    final either = await getProformasListUsecase.call(params);
    emit(state.copyWith(loading: false));

    either.fold(
      (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
      (proformas) {
        emit(state.copyWith(
          proformasList: proformas,
          paginationFilterDTO: updatedFilterPagination,
          totalCount: totalCount,
        ));
      },
    );
  }

  onAddedUpdatedProforma(AddedUpdatedProformaEvent event, Emitter<ProformasListState> emit) async {
    final state = this.state as ProformasListLoaded;
    final params = GetProformasListUseCaseParams(dto: state.paginationFilterDTO);
    emit(state.copyWith(loading: true));
    final either = await getProformasListUsecase.call(params);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
      (proformas) => emit(state.copyWith(
        totalCount: totalCount,
        proformasList: proformas,
      )),
    );
  }

  onLoadMoreProformas(LoadMoreProformasEvent event, Emitter<ProformasListState> emit) async {
    final state = this.state as ProformasListLoaded;

    final pageNumber = state.paginationFilterDTO.pageNumber + 1;

    if (pageNumber > state.totalPages) return;
    emit(state.copyWith(loadingPagination: true));
    final paginationFilterDto = state.paginationFilterDTO.copyWith(pageNumber: pageNumber);
    final params = GetProformasListUseCaseParams(dto: paginationFilterDto);

    final either = await getProformasListUsecase.call(params);
    emit(state.copyWith(loadingPagination: false));
    either.fold(
      (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
      (proformas) {
        final updatedProformasList = List.of(state.proformasList);
        updatedProformasList.addAll(proformas);
        emit(state.copyWith(
          totalCount: totalCount,
          proformasList: updatedProformasList,
          paginationFilterDTO: paginationFilterDto,
        ));
      },
    );
  }
}
