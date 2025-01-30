import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/features/deals/presentation/bloc/deals_list/deals_list_bloc.dart';
import 'package:autro_app/features/invoices/domin/repositories/customer_invoices_repository.dart';
import 'package:autro_app/features/invoices/domin/use_cases/delete_customer_invoice_use_case.dart';
import 'package:autro_app/features/invoices/domin/use_cases/get_customers_invoices_list_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/common/domin/dto/pagination_query_payload_dto.dart';
import '../../../domin/entities/customer_invoice_entity.dart';
import '../../../domin/use_cases/create_customer_invoice_use_case.dart';
import '../../../domin/use_cases/update_customer_invoice_use_case.dart';

part 'customers_invoices_list_event.dart';
part 'customers_invoices_list_state.dart';

@injectable
class CustomersInvoicesListBloc extends Bloc<CustomersInvoicesListEvent, CustomersInvoicesListState> {
  final GetCustomersInvoicesListUseCase getInvoicesListUsecase;
  final DeleteCustomerInvoiceUseCase deleteInvoiceUsecase;
  final CustomerInvoicesRepository invoicesRepository;
  final UpdateCustomerInvoiceUseCase updateInvoiceUsecase;
  final CreateCustomerInvoiceUseCase createInvoiceUsecase;
  CustomersInvoicesListBloc(
    this.getInvoicesListUsecase,
    this.invoicesRepository,
    this.deleteInvoiceUsecase,
    this.updateInvoiceUsecase,
    this.createInvoiceUsecase,
  ) : super(CustomersInvoicesListInitial()) {
    on<CustomersInvoicesListEvent>(_mapEvents, transformer: (events, mapper) => events.asyncExpand(mapper));
  }

  int get totalCount => invoicesRepository.totalCount;

  Future _mapEvents(CustomersInvoicesListEvent event, Emitter<CustomersInvoicesListState> emit) async {
    if (event is GetCustomersInvoicesListEvent) {
      await onGetInvoicesList(event, emit);
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
    if (event is DeleteInvoiceEvent) {
      await onDeleteInvoice(event, emit);
    }
    if (event is SearchInputChangedEvent) {
      await onSearchInputChanged(event, emit);
    }
    if (event is AddedUpdatedCustomersInvoiceEvent) {
      await onAddedUpdatedInvoice(event, emit);
    }

    if (event is LoadMoreCustomersInvoicesEvent) {
      await onLoadMoreInvoices(event, emit);
    }
  }

  Future onGetInvoicesList(GetCustomersInvoicesListEvent event, Emitter<CustomersInvoicesListState> emit) async {
    emit(CustomersInvoicesListInitial());
    final paginationFilterDto = PaginationFilterDTO.initial();
    final params = GetCustomersInvoicesListUseCaseParams(dto: paginationFilterDto);
    final either = await getInvoicesListUsecase.call(params);
    either.fold(
      (failure) => emit(CustomersInvoicesListError(failure: failure)),
      (invoices) => emit(CustomersInvoicesListLoaded(
        totalCount: totalCount,
        invoicesList: invoices,
        paginationFilterDTO: paginationFilterDto,
      )),
    );
  }

  Future onUpdatePagination(OnUpdatePaginationEvent event, Emitter<CustomersInvoicesListState> emit) async {
    final state = this.state as CustomersInvoicesListLoaded;
    final paginationFilterDto = state.paginationFilterDTO.copyWith(pageNumber: event.pageNumber);
    final params = GetCustomersInvoicesListUseCaseParams(dto: paginationFilterDto);

    emit(state.copyWith(loadingPagination: true));
    final either = await getInvoicesListUsecase.call(params);
    emit(state.copyWith(loadingPagination: false));
    either.fold(
      (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
      (invoices) => emit(state.copyWith(
        totalCount: totalCount,
        invoicesList: invoices,
        paginationFilterDTO: paginationFilterDto,
      )),
    );
  }

  onHandleFailure(HandleFailureEvent event, Emitter<CustomersInvoicesListState> emit) async {
    emit(CustomersInvoicesListInitial());
    await Future.delayed(const Duration(milliseconds: 300));
    add(GetCustomersInvoicesListEvent());
  }

  onNextPage(NextPageEvent event, Emitter<CustomersInvoicesListState> emit) {
    final state = this.state as CustomersInvoicesListLoaded;
    final pageNumber = state.paginationFilterDTO.pageNumber + 1;
    add(OnUpdatePaginationEvent(pageNumber: pageNumber));
  }

  onPreviousPage(PreviousPageEvent event, Emitter<CustomersInvoicesListState> emit) {
    final state = this.state as CustomersInvoicesListLoaded;
    final pageNumber = state.paginationFilterDTO.pageNumber - 1;
    add(OnUpdatePaginationEvent(pageNumber: pageNumber));
  }

  onDeleteInvoice(DeleteInvoiceEvent event, Emitter<CustomersInvoicesListState> emit) async {
    final state = this.state as CustomersInvoicesListLoaded;
    emit(state.copyWith(loading: true));
    final either = await deleteInvoiceUsecase.call(event.invoiceId);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
      (_) {
        final updatedInvoicesList = List.of(state.invoicesList);
        updatedInvoicesList.removeWhere((element) => element.id == event.invoiceId);
        const message = 'Invoice Deleted Successfully';
        emit(state.copyWith(
          invoicesList: updatedInvoicesList,
          failureOrSuccessOption: some(right(message)),
          totalCount: totalCount - 1,
        ));
      },
    );
    if (event.context.mounted) {
      event.context.read<DealsListBloc>().add(GetDealsListEvent());
    }
  }

  onSearchInputChanged(SearchInputChangedEvent event, Emitter<CustomersInvoicesListState> emit) async {
    if (state is CustomersInvoicesListLoaded) {
      final state = this.state as CustomersInvoicesListLoaded;

      emit(state.copyWith(loading: true));

      final conditions = List.of(state.paginationFilterDTO.filter.conditions);

      final newCondition = FilterConditionDTO.searchFilter(event.keyword);

      conditions.removeWhere((condition) => condition.fieldName == newCondition.fieldName);
      if (event.keyword.isNotEmpty) conditions.add(newCondition);

      final updatedFilter = state.paginationFilterDTO.filter.copyWith(conditions: conditions);

      final updatedFilterPagination = PaginationFilterDTO.initial().copyWith(filter: updatedFilter);

      final params = GetCustomersInvoicesListUseCaseParams(dto: updatedFilterPagination);

      final either = await getInvoicesListUsecase.call(params);
      emit(state.copyWith(loading: false));

      either.fold(
        (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
        (invoices) {
          emit(state.copyWith(
            invoicesList: invoices,
            paginationFilterDTO: updatedFilterPagination,
            totalCount: totalCount,
          ));
        },
      );
    }
  }

  onAddedUpdatedInvoice(AddedUpdatedCustomersInvoiceEvent event, Emitter<CustomersInvoicesListState> emit) async {
    final state = this.state as CustomersInvoicesListLoaded;
    final params = GetCustomersInvoicesListUseCaseParams(dto: state.paginationFilterDTO);
    emit(state.copyWith(loading: true));
    final either = await getInvoicesListUsecase.call(params);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
      (invoices) => emit(state.copyWith(
        totalCount: totalCount,
        invoicesList: invoices,
      )),
    );
  }

  onLoadMoreInvoices(LoadMoreCustomersInvoicesEvent event, Emitter<CustomersInvoicesListState> emit) async {
    final state = this.state as CustomersInvoicesListLoaded;

    final pageNumber = state.paginationFilterDTO.pageNumber + 1;

    if (pageNumber > state.totalPages) return;
    emit(state.copyWith(loadingPagination: true));
    final paginationFilterDto = state.paginationFilterDTO.copyWith(pageNumber: pageNumber);
    final params = GetCustomersInvoicesListUseCaseParams(dto: paginationFilterDto);

    final either = await getInvoicesListUsecase.call(params);
    emit(state.copyWith(loadingPagination: false));
    either.fold(
      (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
      (invoices) {
        final updatedInvoicesList = List.of(state.invoicesList);
        updatedInvoicesList.addAll(invoices);
        emit(state.copyWith(
          totalCount: totalCount,
          invoicesList: updatedInvoicesList,
          paginationFilterDTO: paginationFilterDto,
        ));
      },
    );
  }
}
