import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/features/deals/domin/repositories/deals_repository.dart';
import 'package:autro_app/features/deals/domin/use_cases/delete_deal_use_case.dart';
import 'package:autro_app/features/deals/domin/use_cases/get_deals_list_use_case.dart';
import 'package:autro_app/features/proformas/presentation/bloc/customers_proformas_list/customers_proformas_list_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/common/domin/dto/pagination_query_payload_dto.dart';
import '../../../../invoices/presentation/bloc/customers_invoices_list/customers_invoices_list_bloc.dart';
import '../../../domin/entities/deal_entity.dart';
import '../../../domin/use_cases/create_deal_use_case.dart';
import '../../../domin/use_cases/update_deal_use_case.dart';

part 'deals_list_event.dart';
part 'deals_list_state.dart';

@injectable
class DealsListBloc extends Bloc<DealsListEvent, DealsListState> {
  final GetDealsListUseCase getDealsListUsecase;
  final DeleteDealUseCase deleteDealUsecase;
  final DealsRepository dealsRepository;
  final UpdateDealUseCase updateDealUsecase;
  final CreateDealUseCase createDealUsecase;
  DealsListBloc(
    this.getDealsListUsecase,
    this.dealsRepository,
    this.deleteDealUsecase,
    this.updateDealUsecase,
    this.createDealUsecase,
  ) : super(DealsListInitial()) {
    on<DealsListEvent>(_mapEvents, transformer: (events, mapper) => events.asyncExpand(mapper));
  }

  int get totalCount => dealsRepository.totalCount;

  Future _mapEvents(DealsListEvent event, Emitter<DealsListState> emit) async {
    if (event is GetDealsListEvent) {
      await onGetDealsList(event, emit);
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
    if (event is DeleteDealEvent) {
      await onDeleteDeal(event, emit);
    }
    if (event is SearchInputChangedEvent) {
      await onSearchInputChanged(event, emit);
    }
    if (event is AddedUpdatedDealEvent) {
      await onAddedUpdatedDeal(event, emit);
    }
    if (event is LoadMoreDealsEvent) {
      await onLoadMoreDeals(event, emit);
    }
    if (event is CreateDealEvent) {
      await _onCreateNewDeal(event, emit);
    }
  }

  Future onGetDealsList(GetDealsListEvent event, Emitter<DealsListState> emit) async {
    emit(DealsListInitial());
    final paginationFilterDto = PaginationFilterDTO.initial();
    final params = GetDealsListUseCaseParams(dto: paginationFilterDto);
    final either = await getDealsListUsecase.call(params);
    either.fold(
      (failure) => emit(DealsListError(failure: failure)),
      (deals) => emit(DealsListLoaded(
        totalCount: totalCount,
        dealsList: deals,
        paginationFilterDTO: paginationFilterDto,
      )),
    );
  }

  Future onUpdatePagination(OnUpdatePaginationEvent event, Emitter<DealsListState> emit) async {
    final state = this.state as DealsListLoaded;
    final paginationFilterDto = state.paginationFilterDTO.copyWith(pageNumber: event.pageNumber);
    final params = GetDealsListUseCaseParams(dto: paginationFilterDto);

    emit(state.copyWith(loadingPagination: true));
    final either = await getDealsListUsecase.call(params);
    emit(state.copyWith(loadingPagination: false));
    either.fold(
      (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
      (deals) => emit(state.copyWith(
        totalCount: totalCount,
        dealsList: deals,
        paginationFilterDTO: paginationFilterDto,
      )),
    );
  }

  onHandleFailure(HandleFailureEvent event, Emitter<DealsListState> emit) async {
    emit(DealsListInitial());
    await Future.delayed(const Duration(milliseconds: 300));
    add(GetDealsListEvent());
  }

  onNextPage(NextPageEvent event, Emitter<DealsListState> emit) {
    final state = this.state as DealsListLoaded;
    final pageNumber = state.paginationFilterDTO.pageNumber + 1;
    add(OnUpdatePaginationEvent(pageNumber: pageNumber));
  }

  onPreviousPage(PreviousPageEvent event, Emitter<DealsListState> emit) {
    final state = this.state as DealsListLoaded;
    final pageNumber = state.paginationFilterDTO.pageNumber - 1;
    add(OnUpdatePaginationEvent(pageNumber: pageNumber));
  }

  onDeleteDeal(DeleteDealEvent event, Emitter<DealsListState> emit) async {
    final state = this.state as DealsListLoaded;
    emit(state.copyWith(loading: true));
    final either = await deleteDealUsecase.call(event.dealId);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
      (_) {
        final updatedDealsList = List.of(state.dealsList);
        updatedDealsList.removeWhere((element) => element.id == event.dealId);
        const message = 'Deal Deleted Successfully';
        emit(state.copyWith(
          dealsList: updatedDealsList,
          failureOrSuccessOption: some(right(message)),
          totalCount: totalCount - 1,
        ));
      },
    );

    if (event.context.mounted) {
      event.context.read<CustomersProformasListBloc>().add(GetProformasListEvent());
      event.context.read<CustomersInvoicesListBloc>().add(GetCustomersInvoicesListEvent());
    }
  }

  onSearchInputChanged(SearchInputChangedEvent event, Emitter<DealsListState> emit) async {
    if (state is DealsListLoaded) {
      final state = this.state as DealsListLoaded;

      emit(state.copyWith(loading: true));

      final conditions = List.of(state.paginationFilterDTO.filter.conditions);

      final newCondition = FilterConditionDTO.searchFilter(event.keyword);

      conditions.removeWhere((condition) => condition.fieldName == newCondition.fieldName);
      if (event.keyword.isNotEmpty) conditions.add(newCondition);

      final updatedFilter = state.paginationFilterDTO.filter.copyWith(conditions: conditions);

      final updatedFilterPagination = PaginationFilterDTO.initial().copyWith(filter: updatedFilter);

      final params = GetDealsListUseCaseParams(dto: updatedFilterPagination);

      final either = await getDealsListUsecase.call(params);
      emit(state.copyWith(loading: false));

      either.fold(
        (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
        (deals) {
          emit(state.copyWith(
            dealsList: deals,
            paginationFilterDTO: updatedFilterPagination,
            totalCount: totalCount,
          ));
        },
      );
    }
  }

  onAddedUpdatedDeal(AddedUpdatedDealEvent event, Emitter<DealsListState> emit) async {
    final state = this.state as DealsListLoaded;
    final params = GetDealsListUseCaseParams(dto: state.paginationFilterDTO);
    emit(state.copyWith(loading: true));
    final either = await getDealsListUsecase.call(params);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
      (deals) => emit(state.copyWith(
        totalCount: totalCount,
        dealsList: deals,
      )),
    );
  }

  onLoadMoreDeals(LoadMoreDealsEvent event, Emitter<DealsListState> emit) async {
    final state = this.state as DealsListLoaded;

    final pageNumber = state.paginationFilterDTO.pageNumber + 1;

    if (pageNumber > state.totalPages) return;
    emit(state.copyWith(loadingPagination: true));
    final paginationFilterDto = state.paginationFilterDTO.copyWith(pageNumber: pageNumber);
    final params = GetDealsListUseCaseParams(dto: paginationFilterDto);

    final either = await getDealsListUsecase.call(params);
    emit(state.copyWith(loadingPagination: false));
    either.fold(
      (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
      (deals) {
        final updatedDealsList = List.of(state.dealsList);
        updatedDealsList.addAll(deals);
        emit(state.copyWith(
          totalCount: totalCount,
          dealsList: updatedDealsList,
          paginationFilterDTO: paginationFilterDto,
        ));
      },
    );
  }

  _onCreateNewDeal(CreateDealEvent event, Emitter<DealsListState> emit) async {
    if (this.state is! DealsListLoaded) {
      final paginationFilterDto = PaginationFilterDTO.initial();
      final params = GetDealsListUseCaseParams(dto: paginationFilterDto);
      final either = await getDealsListUsecase.call(params);
      either.fold(
        (failure) => emit(DealsListError(failure: failure)),
        (deals) => emit(DealsListLoaded(
          totalCount: totalCount,
          dealsList: deals,
          paginationFilterDTO: paginationFilterDto,
        )),
      );
    }

    final state = this.state as DealsListLoaded;
    final params = CreateDealUseCaseParams(customerProformaId: event.customerProformaId);
    final either = await createDealUsecase.call(params);

    either.fold(
      (l) => emit(state.copyWith(failureOrSuccessOption: some(left(l)))),
      (deal) {
        final updateDealsList = List.of(state.dealsList)..insert(0, deal);
        emit(state.copyWith(dealsList: updateDealsList));
      },
    );
  }
}
