import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/bills/domin/entities/bills_summary_entity.dart';
import 'package:autro_app/features/bills/domin/use_cases/get_bills_list_use_case.dart';
import 'package:autro_app/features/bills/domin/use_cases/get_bills_summary_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/common/domin/dto/pagination_query_payload_dto.dart';
import '../../../domin/entities/bill_entity.dart';
import '../../../domin/repostiries/bills_respository.dart';
import '../../../domin/use_cases/add_bill_use_case.dart';
import '../../../domin/use_cases/delete_bill_use_case.dart';
import '../../../domin/use_cases/update_bill_use_case.dart';

part 'bills_list_event.dart';
part 'bills_list_state.dart';

@injectable
class BillsListBloc extends Bloc<BillsListEvent, BillsListState> {
  final GetBillsListUseCase getBillsListUsecase;
  final DeleteBillUseCase deleteBillUsecase;
  final BillsRepository billsRepository;
  final GetBillsSummaryUseCase getBillsSummaryUsecase;
  final UpdateBillUseCase updateBillUsecase;
  final AddBillUseCase createBillUsecase;
  BillsListBloc(
    this.getBillsListUsecase,
    this.billsRepository,
    this.deleteBillUsecase,
    this.updateBillUsecase,
    this.createBillUsecase,
    this.getBillsSummaryUsecase,
  ) : super(BillsListInitial()) {
    on<BillsListEvent>(_mapEvents);
  }

  int get billsCount => billsRepository.billsCount;

  Future _mapEvents(BillsListEvent event, Emitter<BillsListState> emit) async {
    if (event is GetBillsListEvent) {
      await onGetBillsList(event, emit);
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
    if (event is DeleteBillEvent) {
      await onDeleteBill(event, emit);
    }
    if (event is SearchInputChangedEvent) {
      await onSearchInputChanged(event, emit);
    }
    if (event is AddedUpdatedBillEvent) {
      await onAddedUpdatedBill(event, emit);
    }

    if (event is LoadMoreBillsEvent) {
      await onLoadMoreBills(event, emit);
    }
    if (event is GetBillsSummaryEvent) {
      await onGetBillsSummary(event, emit);
    }
  }

  Future onGetBillsList(GetBillsListEvent event, Emitter<BillsListState> emit) async {
    emit(BillsListInitial());
    final paginationFilterDto = PaginationFilterDTO.initial();
    final params = GetBillsListUseCaseParams(paginationFilterDTO: paginationFilterDto);
    final either = await getBillsListUsecase.call(params);
    either.fold(
      (failure) => emit(BillsListError(failure: failure)),
      (bills) {
        emit(BillsListLoaded(
          totalCount: billsCount,
          billsList: bills,
          paginationFilterDTO: paginationFilterDto,
        ));
        add(GetBillsSummaryEvent());
      },
    );
  }

  Future onUpdatePagination(OnUpdatePaginationEvent event, Emitter<BillsListState> emit) async {
    final state = this.state as BillsListLoaded;
    final paginationFilterDto = state.paginationFilterDTO.copyWith(pageNumber: event.pageNumber);
    final params = GetBillsListUseCaseParams(paginationFilterDTO: paginationFilterDto);

    emit(state.copyWith(loadingPagination: true));
    final either = await getBillsListUsecase.call(params);
    emit(state.copyWith(loadingPagination: false));
    either.fold(
      (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
      (bills) => emit(state.copyWith(
        totalCount: billsCount,
        billsList: bills,
        paginationFilterDTO: paginationFilterDto,
      )),
    );
  }

  onHandleFailure(HandleFailureEvent event, Emitter<BillsListState> emit) async {
    emit(BillsListInitial());
    await Future.delayed(const Duration(milliseconds: 300));
    add(GetBillsListEvent());
  }

  onNextPage(NextPageEvent event, Emitter<BillsListState> emit) {
    final state = this.state as BillsListLoaded;
    final pageNumber = state.paginationFilterDTO.pageNumber + 1;
    add(OnUpdatePaginationEvent(pageNumber: pageNumber));
  }

  onPreviousPage(PreviousPageEvent event, Emitter<BillsListState> emit) {
    final state = this.state as BillsListLoaded;
    final pageNumber = state.paginationFilterDTO.pageNumber - 1;
    add(OnUpdatePaginationEvent(pageNumber: pageNumber));
  }

  onDeleteBill(DeleteBillEvent event, Emitter<BillsListState> emit) async {
    final state = this.state as BillsListLoaded;
    emit(state.copyWith(loading: true));
    final either = await deleteBillUsecase.call(event.billId);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
      (_) {
        final updatedBillsList = List.of(state.billsList);
        updatedBillsList.removeWhere((element) => element.id == event.billId);
        const message = 'Bill Deleted Successfully';
        emit(state.copyWith(
          billsList: updatedBillsList,
          failureOrSuccessOption: some(right(message)),
          totalCount: billsCount - 1,
        ));
      },
    );
    add(GetBillsSummaryEvent());
  }

  onSearchInputChanged(SearchInputChangedEvent event, Emitter<BillsListState> emit) async {
    final state = this.state as BillsListLoaded;

    emit(state.copyWith(loading: true));

    final conditions = List.of(state.paginationFilterDTO.filter.conditions);

    final newCondition = FilterConditionDTO.searchFilter(event.keyword);

    conditions.removeWhere((condition) => condition.fieldName == newCondition.fieldName);
    if (event.keyword.isNotEmpty) conditions.add(newCondition);

    final updatedFilter = state.paginationFilterDTO.filter.copyWith(conditions: conditions);

    final updatedFilterPagination = PaginationFilterDTO.initial().copyWith(filter: updatedFilter);

    final params = GetBillsListUseCaseParams(paginationFilterDTO: updatedFilterPagination);

    final either = await getBillsListUsecase.call(params);
    emit(state.copyWith(loading: false));

    either.fold(
      (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
      (bills) {
        emit(state.copyWith(
          billsList: bills,
          paginationFilterDTO: updatedFilterPagination,
          totalCount: billsCount,
        ));
      },
    );
  }

  onAddedUpdatedBill(AddedUpdatedBillEvent event, Emitter<BillsListState> emit) async {
    final state = this.state as BillsListLoaded;
    final params = GetBillsListUseCaseParams(paginationFilterDTO: state.paginationFilterDTO);
    emit(state.copyWith(loading: true));
    final either = await getBillsListUsecase.call(params);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
      (bills) {
        emit(state.copyWith(
          totalCount: billsCount,
          billsList: bills,
        ));
      },
    );
    add(GetBillsSummaryEvent());
  }

  onLoadMoreBills(LoadMoreBillsEvent event, Emitter<BillsListState> emit) async {
    final state = this.state as BillsListLoaded;

    final pageNumber = state.paginationFilterDTO.pageNumber + 1;

    if (pageNumber > state.totalPages) return;
    emit(state.copyWith(loadingPagination: true));
    final paginationFilterDto = state.paginationFilterDTO.copyWith(pageNumber: pageNumber);
    final params = GetBillsListUseCaseParams(paginationFilterDTO: paginationFilterDto);

    final either = await getBillsListUsecase.call(params);
    emit(state.copyWith(loadingPagination: false));
    either.fold(
      (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
      (bills) {
        final updatedBillsList = List.of(state.billsList);
        updatedBillsList.addAll(bills);
        emit(state.copyWith(
          totalCount: billsCount,
          billsList: updatedBillsList,
          paginationFilterDTO: paginationFilterDto,
        ));
      },
    );
  }

  onGetBillsSummary(GetBillsSummaryEvent event, Emitter<BillsListState> emit) async {
    if (state is BillsListLoaded) {
      final state = this.state as BillsListLoaded;
      emit(state.copyWith(loadingSummary: true));
      final either = await getBillsSummaryUsecase.call(NoParams());
      either.fold(
        (failure) => null,
        (billsSummary) => emit(state.copyWith(billsSummary: billsSummary, loadingSummary: false)),
      );
    }
  }
}
