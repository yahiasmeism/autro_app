import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/features/deals/presentation/bloc/deals_list/deals_list_bloc.dart';
import 'package:autro_app/features/proformas/domin/use_cases/delete_supplier_proforma_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/common/domin/dto/pagination_query_payload_dto.dart';
import '../../../../deals/presentation/bloc/deal_details/deal_details_cubit.dart';
import '../../../domin/entities/supplier_proforma_entity.dart';
import '../../../domin/repositories/supplier_invoices_repository.dart';
import '../../../domin/use_cases/create_supplier_proforma_use_case.dart';
import '../../../domin/use_cases/get_supplier_proforma_list_use_case.dart';
import '../../../domin/use_cases/update_supplier_proforma_use_case.dart';

part 'suppliers_proformas_list_event.dart';
part 'suppliers_proformas_list_state.dart';

@injectable
class SuppliersProformasListBloc extends Bloc<SuppliersProformasListEvent, SuppliersProformasListState> {
  final GetSuppliersProformasListUseCase getProformasListUsecase;
  final DeleteSupplierProformaUseCase deleteProformaUsecase;
  final SupplierProformasRepository proformasRepository;
  final UpdateSupplierProformaUseCase updateProformaUsecase;
  final CreateSupplierProformaUseCase createProformaUsecase;
  SuppliersProformasListBloc(
    this.getProformasListUsecase,
    this.proformasRepository,
    this.deleteProformaUsecase,
    this.updateProformaUsecase,
    this.createProformaUsecase,
  ) : super(SuppliersProformasListInitial()) {
    on<SuppliersProformasListEvent>(_mapEvents, transformer: (events, mapper) => events.asyncExpand(mapper));
  }

  int get totalCount => proformasRepository.totalCount;

  Future _mapEvents(SuppliersProformasListEvent event, Emitter<SuppliersProformasListState> emit) async {
    if (event is GetSuppliersProformasListEvent) {
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
    if (event is AddedUpdatedSuppliersProformaEvent) {
      await onAddedUpdatedProforma(event, emit);
    }

    if (event is LoadMoreSuppliersProformasEvent) {
      await onLoadMoreProformas(event, emit);
    }
  }

  Future onGetProformasList(GetSuppliersProformasListEvent event, Emitter<SuppliersProformasListState> emit) async {
    emit(SuppliersProformasListInitial());
    final paginationFilterDto = PaginationFilterDTO.initial();
    final params = GetSupplierProformasListUseCaseParams(dto: paginationFilterDto);
    final either = await getProformasListUsecase.call(params);
    either.fold(
      (failure) => emit(SuppliersProformasListError(failure: failure)),
      (proformas) => emit(SuppliersProformasListLoaded(
        totalCount: totalCount,
        proformasList: proformas,
        paginationFilterDTO: paginationFilterDto,
      )),
    );
  }

  Future onUpdatePagination(OnUpdatePaginationEvent event, Emitter<SuppliersProformasListState> emit) async {
    final state = this.state as SuppliersProformasListLoaded;
    final paginationFilterDto = state.paginationFilterDTO.copyWith(pageNumber: event.pageNumber);
    final params = GetSupplierProformasListUseCaseParams(dto: paginationFilterDto);

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

  onHandleFailure(HandleFailureEvent event, Emitter<SuppliersProformasListState> emit) async {
    emit(SuppliersProformasListInitial());
    await Future.delayed(const Duration(milliseconds: 300));
    add(GetSuppliersProformasListEvent());
  }

  onNextPage(NextPageEvent event, Emitter<SuppliersProformasListState> emit) {
    final state = this.state as SuppliersProformasListLoaded;
    final pageNumber = state.paginationFilterDTO.pageNumber + 1;
    add(OnUpdatePaginationEvent(pageNumber: pageNumber));
  }

  onPreviousPage(PreviousPageEvent event, Emitter<SuppliersProformasListState> emit) {
    final state = this.state as SuppliersProformasListLoaded;
    final pageNumber = state.paginationFilterDTO.pageNumber - 1;
    add(OnUpdatePaginationEvent(pageNumber: pageNumber));
  }

  onDeleteProforma(DeleteProformaEvent event, Emitter<SuppliersProformasListState> emit) async {
    final state = this.state as SuppliersProformasListLoaded;
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
    if (event.context.mounted) {
      event.context.read<DealsListBloc>().add(GetDealsListEvent());
      event.context.read<DealDetailsCubit>().refresh();
    }
  }

  onSearchInputChanged(SearchInputChangedEvent event, Emitter<SuppliersProformasListState> emit) async {
    if (state is SuppliersProformasListLoaded) {
      final state = this.state as SuppliersProformasListLoaded;

      emit(state.copyWith(loading: true));

      final conditions = List.of(state.paginationFilterDTO.filter.conditions);

      final newCondition = FilterConditionDTO.searchFilter(event.keyword);

      conditions.removeWhere((condition) => condition.fieldName == newCondition.fieldName);
      if (event.keyword.isNotEmpty) conditions.add(newCondition);

      final updatedFilter = state.paginationFilterDTO.filter.copyWith(conditions: conditions);

      final updatedFilterPagination = PaginationFilterDTO.initial().copyWith(filter: updatedFilter);

      final params = GetSupplierProformasListUseCaseParams(dto: updatedFilterPagination);

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
  }

  onAddedUpdatedProforma(AddedUpdatedSuppliersProformaEvent event, Emitter<SuppliersProformasListState> emit) async {
    final state = this.state as SuppliersProformasListLoaded;
    final params = GetSupplierProformasListUseCaseParams(dto: state.paginationFilterDTO);
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

  onLoadMoreProformas(LoadMoreSuppliersProformasEvent event, Emitter<SuppliersProformasListState> emit) async {
    final state = this.state as SuppliersProformasListLoaded;

    final pageNumber = state.paginationFilterDTO.pageNumber + 1;

    if (pageNumber > state.totalPages) return;
    emit(state.copyWith(loadingPagination: true));
    final paginationFilterDto = state.paginationFilterDTO.copyWith(pageNumber: pageNumber);
    final params = GetSupplierProformasListUseCaseParams(dto: paginationFilterDto);

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
