import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/features/invoices/domin/repositories/invoices_repository.dart';
import 'package:autro_app/features/invoices/domin/use_cases/delete_invoice_use_case.dart';
import 'package:autro_app/features/invoices/domin/use_cases/get_invoices_list_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/common/domin/dto/pagination_query_payload_dto.dart';
import '../../../domin/entities/invoice_entity.dart';
import '../../../domin/use_cases/create_invoice_use_case.dart';
import '../../../domin/use_cases/update_invoice_use_case.dart';

part 'invoices_list_event.dart';
part 'invoices_list_state.dart';

@injectable
class InvoicesListBloc extends Bloc<InvoicesListEvent, InvoicesListState> {
  final GetInvoicesListUseCase getInvoicesListUsecase;
  final DeleteInvoiceUseCase deleteInvoiceUsecase;
  final InvoicesRepository invoicesRepository;
  final UpdateInvoiceUseCase updateInvoiceUsecase;
  final CreateInvoiceUseCase createInvoiceUsecase;
  InvoicesListBloc(
    this.getInvoicesListUsecase,
    this.invoicesRepository,
    this.deleteInvoiceUsecase,
    this.updateInvoiceUsecase,
    this.createInvoiceUsecase,
  ) : super(InvoicesListInitial()) {
    on<InvoicesListEvent>(_mapEvents);
  }

  int get totalCount => invoicesRepository.totalCount;

  Future _mapEvents(InvoicesListEvent event, Emitter<InvoicesListState> emit) async {
    if (event is GetInvoicesListEvent) {
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
    if (event is AddedUpdatedInvoiceEvent) {
      await onAddedUpdatedInvoice(event, emit);
    }

    if (event is LoadMoreInvoicesEvent) {
      await onLoadMoreInvoices(event, emit);
    }
  }

  Future onGetInvoicesList(GetInvoicesListEvent event, Emitter<InvoicesListState> emit) async {
    emit(InvoicesListInitial());
    final paginationFilterDto = PaginationFilterDTO.initial();
    final params = GetInvoicesListUseCaseParams(dto: paginationFilterDto);
    final either = await getInvoicesListUsecase.call(params);
    either.fold(
      (failure) => emit(InvoicesListError(failure: failure)),
      (invoices) => emit(InvoicesListLoaded(
        totalCount: totalCount,
        invoicesList: invoices,
        paginationFilterDTO: paginationFilterDto,
      )),
    );
  }

  Future onUpdatePagination(OnUpdatePaginationEvent event, Emitter<InvoicesListState> emit) async {
    final state = this.state as InvoicesListLoaded;
    final paginationFilterDto = state.paginationFilterDTO.copyWith(pageNumber: event.pageNumber);
    final params = GetInvoicesListUseCaseParams(dto: paginationFilterDto);

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

  onHandleFailure(HandleFailureEvent event, Emitter<InvoicesListState> emit) async {
    emit(InvoicesListInitial());
    await Future.delayed(const Duration(milliseconds: 300));
    add(GetInvoicesListEvent());
  }

  onNextPage(NextPageEvent event, Emitter<InvoicesListState> emit) {
    final state = this.state as InvoicesListLoaded;
    final pageNumber = state.paginationFilterDTO.pageNumber + 1;
    add(OnUpdatePaginationEvent(pageNumber: pageNumber));
  }

  onPreviousPage(PreviousPageEvent event, Emitter<InvoicesListState> emit) {
    final state = this.state as InvoicesListLoaded;
    final pageNumber = state.paginationFilterDTO.pageNumber - 1;
    add(OnUpdatePaginationEvent(pageNumber: pageNumber));
  }

  onDeleteInvoice(DeleteInvoiceEvent event, Emitter<InvoicesListState> emit) async {
    final state = this.state as InvoicesListLoaded;
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
  }

  onSearchInputChanged(SearchInputChangedEvent event, Emitter<InvoicesListState> emit) async {
    if (state is InvoicesListLoaded) {
      final state = this.state as InvoicesListLoaded;

      emit(state.copyWith(loading: true));

      final conditions = List.of(state.paginationFilterDTO.filter.conditions);

      final newCondition = FilterConditionDTO.searchFilter(event.keyword);

      conditions.removeWhere((condition) => condition.fieldName == newCondition.fieldName);
      if (event.keyword.isNotEmpty) conditions.add(newCondition);

      final updatedFilter = state.paginationFilterDTO.filter.copyWith(conditions: conditions);

      final updatedFilterPagination = PaginationFilterDTO.initial().copyWith(filter: updatedFilter);

      final params = GetInvoicesListUseCaseParams(dto: updatedFilterPagination);

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

  onAddedUpdatedInvoice(AddedUpdatedInvoiceEvent event, Emitter<InvoicesListState> emit) async {
    final state = this.state as InvoicesListLoaded;
    final params = GetInvoicesListUseCaseParams(dto: state.paginationFilterDTO);
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

  onLoadMoreInvoices(LoadMoreInvoicesEvent event, Emitter<InvoicesListState> emit) async {
    final state = this.state as InvoicesListLoaded;

    final pageNumber = state.paginationFilterDTO.pageNumber + 1;

    if (pageNumber > state.totalPages) return;
    emit(state.copyWith(loadingPagination: true));
    final paginationFilterDto = state.paginationFilterDTO.copyWith(pageNumber: pageNumber);
    final params = GetInvoicesListUseCaseParams(dto: paginationFilterDto);

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
