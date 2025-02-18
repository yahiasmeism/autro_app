import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/features/deals/presentation/bloc/deals_list/deals_list_bloc.dart';
import 'package:autro_app/features/invoices/domin/repositories/supplier_invoices_repository.dart';
import 'package:autro_app/features/invoices/domin/use_cases/delete_supplier_invoice_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/common/domin/dto/pagination_query_payload_dto.dart';
import '../../../../deals/presentation/bloc/deal_details/deal_details_cubit.dart';
import '../../../domin/entities/supplier_invoice_entity.dart';
import '../../../domin/use_cases/create_supplier_invoice_use_case.dart';
import '../../../domin/use_cases/get_supplier_invoices_list_use_case.dart';
import '../../../domin/use_cases/update_supplier_invoice_use_case.dart';

part 'suppliers_invoices_list_event.dart';
part 'suppliers_invoices_list_state.dart';

@injectable
class SuppliersInvoicesListBloc extends Bloc<SuppliersInvoicesListEvent, SuppliersInvoicesListState> {
  final GetSuppliersInvoicesListUseCase getInvoicesListUsecase;
  final DeleteSupplierInvoiceUseCase deleteInvoiceUsecase;
  final SupplierInvoicesRepository invoicesRepository;
  final UpdateSupplierInvoiceUseCase updateInvoiceUsecase;
  final CreateSupplierInvoiceUseCase createInvoiceUsecase;
  SuppliersInvoicesListBloc(
    this.getInvoicesListUsecase,
    this.invoicesRepository,
    this.deleteInvoiceUsecase,
    this.updateInvoiceUsecase,
    this.createInvoiceUsecase,
  ) : super(SuppliersInvoicesListInitial()) {
    on<SuppliersInvoicesListEvent>(_mapEvents, transformer: (events, mapper) => events.asyncExpand(mapper));
  }

  int get totalCount => invoicesRepository.totalCount;

  Future _mapEvents(SuppliersInvoicesListEvent event, Emitter<SuppliersInvoicesListState> emit) async {
    if (event is GetSuppliersInvoicesListEvent) {
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
    if (event is AddedUpdatedSuppliersInvoiceEvent) {
      await onAddedUpdatedInvoice(event, emit);
    }

    if (event is LoadMoreSuppliersInvoicesEvent) {
      await onLoadMoreInvoices(event, emit);
    }
  }

  Future onGetInvoicesList(GetSuppliersInvoicesListEvent event, Emitter<SuppliersInvoicesListState> emit) async {
    emit(SuppliersInvoicesListInitial());
    final paginationFilterDto = PaginationFilterDTO.initial();
    final params = GetSupplierInvoicesListUseCaseParams(dto: paginationFilterDto);
    final either = await getInvoicesListUsecase.call(params);
    either.fold(
      (failure) => emit(SuppliersInvoicesListError(failure: failure)),
      (invoices) => emit(SuppliersInvoicesListLoaded(
        totalCount: totalCount,
        invoicesList: invoices,
        paginationFilterDTO: paginationFilterDto,
      )),
    );
  }

  Future onUpdatePagination(OnUpdatePaginationEvent event, Emitter<SuppliersInvoicesListState> emit) async {
    final state = this.state as SuppliersInvoicesListLoaded;
    final paginationFilterDto = state.paginationFilterDTO.copyWith(pageNumber: event.pageNumber);
    final params = GetSupplierInvoicesListUseCaseParams(dto: paginationFilterDto);

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

  onHandleFailure(HandleFailureEvent event, Emitter<SuppliersInvoicesListState> emit) async {
    emit(SuppliersInvoicesListInitial());
    await Future.delayed(const Duration(milliseconds: 300));
    add(GetSuppliersInvoicesListEvent());
  }

  onNextPage(NextPageEvent event, Emitter<SuppliersInvoicesListState> emit) {
    final state = this.state as SuppliersInvoicesListLoaded;
    final pageNumber = state.paginationFilterDTO.pageNumber + 1;
    add(OnUpdatePaginationEvent(pageNumber: pageNumber));
  }

  onPreviousPage(PreviousPageEvent event, Emitter<SuppliersInvoicesListState> emit) {
    final state = this.state as SuppliersInvoicesListLoaded;
    final pageNumber = state.paginationFilterDTO.pageNumber - 1;
    add(OnUpdatePaginationEvent(pageNumber: pageNumber));
  }

  onDeleteInvoice(DeleteInvoiceEvent event, Emitter<SuppliersInvoicesListState> emit) async {
    final state = this.state as SuppliersInvoicesListLoaded;
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
      event.context.read<DealsListBloc>().add(const GetDealsListEvent());
      event.context.read<DealDetailsCubit>().refresh();
    }
  }

  onSearchInputChanged(SearchInputChangedEvent event, Emitter<SuppliersInvoicesListState> emit) async {
    if (state is SuppliersInvoicesListLoaded) {
      final state = this.state as SuppliersInvoicesListLoaded;

      emit(state.copyWith(loading: true));

      final conditions = List.of(state.paginationFilterDTO.filter.conditions);

      final newCondition = FilterConditionDTO.searchFilter(event.keyword);

      conditions.removeWhere((condition) => condition.fieldName == newCondition.fieldName);
      if (event.keyword.isNotEmpty) conditions.add(newCondition);

      final updatedFilter = state.paginationFilterDTO.filter.copyWith(conditions: conditions);

      final updatedFilterPagination = PaginationFilterDTO.initial().copyWith(filter: updatedFilter);

      final params = GetSupplierInvoicesListUseCaseParams(dto: updatedFilterPagination);

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

  onAddedUpdatedInvoice(AddedUpdatedSuppliersInvoiceEvent event, Emitter<SuppliersInvoicesListState> emit) async {
    final state = this.state as SuppliersInvoicesListLoaded;
    final params = GetSupplierInvoicesListUseCaseParams(dto: state.paginationFilterDTO);
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

  onLoadMoreInvoices(LoadMoreSuppliersInvoicesEvent event, Emitter<SuppliersInvoicesListState> emit) async {
    final state = this.state as SuppliersInvoicesListLoaded;

    final pageNumber = state.paginationFilterDTO.pageNumber + 1;

    if (pageNumber > state.totalPages) return;
    emit(state.copyWith(loadingPagination: true));
    final paginationFilterDto = state.paginationFilterDTO.copyWith(pageNumber: pageNumber);
    final params = GetSupplierInvoicesListUseCaseParams(dto: paginationFilterDto);

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
