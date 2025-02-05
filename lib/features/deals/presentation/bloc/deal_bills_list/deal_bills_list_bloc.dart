import 'dart:async';

import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/features/deals/domin/repositories/deals_bills_repository.dart';
import 'package:autro_app/features/deals/presentation/bloc/deal_details/deal_details_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/common/domin/dto/pagination_query_payload_dto.dart';
import '../../../domin/entities/deal_bill_entity.dart';
import '../../../domin/use_cases/create_deal_bill_use_case.dart';
import '../../../domin/use_cases/delete_deal_bill_use_case.dart';
import '../../../domin/use_cases/get_deals_bills_list_use_case.dart';
import '../../../domin/use_cases/update_deal_bill_use_case.dart';
import '../deals_list/deals_list_bloc.dart';

part 'deal_bills_list_state.dart';
part 'deal_bills_list_event.dart';

@injectable
class DealBillsListBloc extends Bloc<DealBillsListEvent, DealBillsListState> {
  final GetDealsBillsListUseCase getDealBillsListUsecase;
  final DeleteDealBillUseCase deleteDealBillUsecase;
  final DealsBillsRepository dealBillsRepository;
  final UpdateDealBillUseCase updateDealBillUsecase;
  final CreateDealBillUseCase createDealBillUsecase;
  DealBillsListBloc(
    this.getDealBillsListUsecase,
    this.deleteDealBillUsecase,
    this.dealBillsRepository,
    this.updateDealBillUsecase,
    this.createDealBillUsecase,
  ) : super(DealBillsListInitial()) {
    on<DealBillsListEvent>(_mapEvents, transformer: (events, mapper) => events.asyncExpand(mapper));
  }

  int get totalCount => dealBillsRepository.dealBillsCount;

  Future _mapEvents(DealBillsListEvent event, Emitter<DealBillsListState> emit) async {
    if (event is GetDealBillsListEvent) {
      await onGetDealBillsList(event, emit);
    }

    if (event is OnUpdatePaginationDealBillsEvent) {
      await onUpdatePagination(event, emit);
    }

    if (event is HandleFailureDealBillsEvent) {
      await onHandleFailure(event, emit);
    }

    if (event is NextPageDealBillsEvent) {
      await onNextPage(event, emit);
    }
    if (event is PreviousPageDealBillsEvent) {
      await onPreviousPage(event, emit);
    }
    if (event is DeleteDealBillEvent) {
      await onDeleteDealBill(event, emit);
    }
    if (event is SearchInputChangedDealBillsEvent) {
      await onSearchInputChanged(event, emit);
    }
    if (event is AddedUpdatedDealBillEvent) {
      await onAddedUpdatedDealBill(event, emit);
    }
  }

  Future onGetDealBillsList(GetDealBillsListEvent event, Emitter<DealBillsListState> emit) async {
    final paginationFilterDto = PaginationFilterDTO.initial();
    final params = GetDealsBillsListUseCaseParams(dealId: event.dealId, dto: paginationFilterDto);
    final either = await getDealBillsListUsecase.call(params);
    either.fold(
      (failure) => emit(DealBillsListError(failure: failure, dealId: event.dealId)),
      (dealBills) => emit(DealBillsListLoaded(
        dealId: event.dealId,
        totalCount: totalCount,
        dealBillsList: dealBills,
        paginationFilterDTO: paginationFilterDto,
      )),
    );
  }

  Future onUpdatePagination(OnUpdatePaginationDealBillsEvent event, Emitter<DealBillsListState> emit) async {
    final state = this.state as DealBillsListLoaded;
    final paginationFilterDto = state.paginationFilterDTO.copyWith(pageNumber: event.pageNumber);
    final params = GetDealsBillsListUseCaseParams(dto: paginationFilterDto, dealId: state.dealId);

    emit(state.copyWith(loadingPagination: true));
    final either = await getDealBillsListUsecase.call(params);
    emit(state.copyWith(loadingPagination: false));
    either.fold(
      (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
      (dealBills) => emit(state.copyWith(
        totalCount: totalCount,
        dealBillsList: dealBills,
        paginationFilterDTO: paginationFilterDto,
      )),
    );
  }

  onHandleFailure(HandleFailureDealBillsEvent event, Emitter<DealBillsListState> emit) async {
    final state = this.state as DealBillsListError;
    emit(DealBillsListInitial());
    await Future.delayed(const Duration(milliseconds: 300));
    add(GetDealBillsListEvent(dealId: state.dealId));
  }

  onNextPage(NextPageDealBillsEvent event, Emitter<DealBillsListState> emit) {
    final state = this.state as DealBillsListLoaded;
    final pageNumber = state.paginationFilterDTO.pageNumber + 1;
    add(OnUpdatePaginationDealBillsEvent(pageNumber: pageNumber));
  }

  onPreviousPage(PreviousPageDealBillsEvent event, Emitter<DealBillsListState> emit) {
    final state = this.state as DealBillsListLoaded;
    final pageNumber = state.paginationFilterDTO.pageNumber - 1;
    add(OnUpdatePaginationDealBillsEvent(pageNumber: pageNumber));
  }

  onDeleteDealBill(DeleteDealBillEvent event, Emitter<DealBillsListState> emit) async {
    final state = this.state as DealBillsListLoaded;
    emit(state.copyWith(loading: true));
    final either = await deleteDealBillUsecase.call(event.dealBillId);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
      (_) {
        final updatedDealBillsList = List.of(state.dealBillsList);
        updatedDealBillsList.removeWhere((element) => element.id == event.dealBillId);
        const message = 'Shipping Invoice Deleted Successfully';
        emit(state.copyWith(
          dealBillsList: updatedDealBillsList,
          failureOrSuccessOption: some(right(message)),
          totalCount: totalCount - 1,
        ));
      },
    );
    if (!event.context.mounted) return;
    event.context.read<DealDetailsCubit>().refresh();
    event.context.read<DealsListBloc>().add(GetDealsListEvent());
  }

  onSearchInputChanged(SearchInputChangedDealBillsEvent event, Emitter<DealBillsListState> emit) async {
    if (state is DealBillsListLoaded) {
      final state = this.state as DealBillsListLoaded;

      emit(state.copyWith(loading: true));

      final conditions = List.of(state.paginationFilterDTO.filter.conditions);

      final newCondition = FilterConditionDTO.searchFilter(event.keyword);

      conditions.removeWhere((condition) => condition.fieldName == newCondition.fieldName);
      if (event.keyword.isNotEmpty) conditions.add(newCondition);

      final updatedFilter = state.paginationFilterDTO.filter.copyWith(conditions: conditions);

      final updatedFilterPagination = PaginationFilterDTO.initial().copyWith(filter: updatedFilter);

      final params = GetDealsBillsListUseCaseParams(dto: updatedFilterPagination, dealId: state.dealId);

      final either = await getDealBillsListUsecase.call(params);
      emit(state.copyWith(loading: false));

      either.fold(
        (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
        (dealBills) {
          emit(state.copyWith(
            dealBillsList: dealBills,
            paginationFilterDTO: updatedFilterPagination,
            totalCount: totalCount,
          ));
        },
      );
    }
  }

  onAddedUpdatedDealBill(AddedUpdatedDealBillEvent event, Emitter<DealBillsListState> emit) async {
    final state = this.state as DealBillsListLoaded;
    final params = GetDealsBillsListUseCaseParams(dto: state.paginationFilterDTO, dealId: state.dealId);
    emit(state.copyWith(loading: true));
    final either = await getDealBillsListUsecase.call(params);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
      (dealBills) => emit(state.copyWith(
        totalCount: totalCount,
        dealBillsList: dealBills,
      )),
    );
  }
}
