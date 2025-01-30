import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/features/shipping-invoices/domin/usecases/get_shipping_invoices_list_use_case.dart';
import 'package:autro_app/features/shipping-invoices/domin/usecases/update_shipping_invoices_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/common/domin/dto/pagination_query_payload_dto.dart';
import '../../../domin/entities/shipping_invoice_entites.dart';
import '../../../domin/repositories/shipping_invoices_repository.dart';
import '../../../domin/usecases/create_shipping_invoice_use_case.dart';
import '../../../domin/usecases/delete_shipping_invoice_use_case.dart';

part 'shipping_invoices_list_state.dart';
part 'shipping_invoices_list_event.dart';

@injectable
class ShippingInvoicesListBloc extends Bloc<ShippingInvoicesListEvent, ShippingInvoicesListState> {
  final GetShippingInvoicesListUseCase getShippingInvoicesListUsecase;
  final DeleteShippingInvoiceUseCase deleteShippingInvoiceUsecase;
  final ShippingInvoicesRepository shippingInvoicesRepository;
  final UpdateShippingInvoicesUseCase updateShippingInvoiceUsecase;
  final CreateShippingInvoiceUseCase createShippingInvoiceUsecase;
  ShippingInvoicesListBloc(
    this.getShippingInvoicesListUsecase,
    this.deleteShippingInvoiceUsecase,
    this.shippingInvoicesRepository,
    this.updateShippingInvoiceUsecase,
    this.createShippingInvoiceUsecase,
  ) : super(ShippingInvoicesListInitial()) {
    on<ShippingInvoicesListEvent>(_mapEvents, transformer: (events, mapper) => events.asyncExpand(mapper));
  }

  int get totalCount => shippingInvoicesRepository.shippingInvoicesCount;

  Future _mapEvents(ShippingInvoicesListEvent event, Emitter<ShippingInvoicesListState> emit) async {
    if (event is GetShippingInvoicesListEvent) {
      await onGetShippingInvoicesList(event, emit);
    }

    if (event is OnUpdatePaginationShippingInvoicesEvent) {
      await onUpdatePagination(event, emit);
    }

    if (event is HandleFailureShippingInvoicesEvent) {
      await onHandleFailure(event, emit);
    }

    if (event is NextPageShippingInvoicesEvent) {
      await onNextPage(event, emit);
    }
    if (event is PreviousPageShippingInvoicesEvent) {
      await onPreviousPage(event, emit);
    }
    if (event is DeleteShippingInvoiceEvent) {
      await onDeleteShippingInvoice(event, emit);
    }
    if (event is SearchInputChangedShippingInvoicesEvent) {
      await onSearchInputChanged(event, emit);
    }
    if (event is AddedUpdatedShippingInvoiceEvent) {
      await onAddedUpdatedShippingInvoice(event, emit);
    }
  }

  Future onGetShippingInvoicesList(GetShippingInvoicesListEvent event, Emitter<ShippingInvoicesListState> emit) async {
    emit(ShippingInvoicesListInitial());
    final paginationFilterDto = PaginationFilterDTO.initial();
    final params = GetShippingInvoicesListUseCaseParams(paginationFilterDTO: paginationFilterDto);
    final either = await getShippingInvoicesListUsecase.call(params);
    either.fold(
      (failure) => emit(ShippingInvoicesListError(failure: failure)),
      (shippingInvoices) => emit(ShippingInvoicesListLoaded(
        totalCount: totalCount,
        shippingInvoicesList: shippingInvoices,
        paginationFilterDTO: paginationFilterDto,
      )),
    );
  }

  Future onUpdatePagination(OnUpdatePaginationShippingInvoicesEvent event, Emitter<ShippingInvoicesListState> emit) async {
    final state = this.state as ShippingInvoicesListLoaded;
    final paginationFilterDto = state.paginationFilterDTO.copyWith(pageNumber: event.pageNumber);
    final params = GetShippingInvoicesListUseCaseParams(paginationFilterDTO: paginationFilterDto);

    emit(state.copyWith(loadingPagination: true));
    final either = await getShippingInvoicesListUsecase.call(params);
    emit(state.copyWith(loadingPagination: false));
    either.fold(
      (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
      (shippingInvoices) => emit(state.copyWith(
        totalCount: totalCount,
        shippingInvoicesList: shippingInvoices,
        paginationFilterDTO: paginationFilterDto,
      )),
    );
  }

  onHandleFailure(HandleFailureShippingInvoicesEvent event, Emitter<ShippingInvoicesListState> emit) async {
    emit(ShippingInvoicesListInitial());
    await Future.delayed(const Duration(milliseconds: 300));
    add(GetShippingInvoicesListEvent());
  }

  onNextPage(NextPageShippingInvoicesEvent event, Emitter<ShippingInvoicesListState> emit) {
    final state = this.state as ShippingInvoicesListLoaded;
    final pageNumber = state.paginationFilterDTO.pageNumber + 1;
    add(OnUpdatePaginationShippingInvoicesEvent(pageNumber: pageNumber));
  }

  onPreviousPage(PreviousPageShippingInvoicesEvent event, Emitter<ShippingInvoicesListState> emit) {
    final state = this.state as ShippingInvoicesListLoaded;
    final pageNumber = state.paginationFilterDTO.pageNumber - 1;
    add(OnUpdatePaginationShippingInvoicesEvent(pageNumber: pageNumber));
  }

  onDeleteShippingInvoice(DeleteShippingInvoiceEvent event, Emitter<ShippingInvoicesListState> emit) async {
    final state = this.state as ShippingInvoicesListLoaded;
    emit(state.copyWith(loading: true));
    final either = await deleteShippingInvoiceUsecase.call(event.shippingInvoiceId);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
      (_) {
        final updatedShippingInvoicesList = List.of(state.shippingInvoicesList);
        updatedShippingInvoicesList.removeWhere((element) => element.id == event.shippingInvoiceId);
        const message = 'Shipping Invoice Deleted Successfully';
        emit(state.copyWith(
          shippingInvoicesList: updatedShippingInvoicesList,
          failureOrSuccessOption: some(right(message)),
          totalCount: totalCount - 1,
        ));
      },
    );
  }

  onSearchInputChanged(SearchInputChangedShippingInvoicesEvent event, Emitter<ShippingInvoicesListState> emit) async {
    if (state is ShippingInvoicesListLoaded) {
      final state = this.state as ShippingInvoicesListLoaded;

      emit(state.copyWith(loading: true));

      final conditions = List.of(state.paginationFilterDTO.filter.conditions);

      final newCondition = FilterConditionDTO.searchFilter(event.keyword);

      conditions.removeWhere((condition) => condition.fieldName == newCondition.fieldName);
      if (event.keyword.isNotEmpty) conditions.add(newCondition);

      final updatedFilter = state.paginationFilterDTO.filter.copyWith(conditions: conditions);

      final updatedFilterPagination = PaginationFilterDTO.initial().copyWith(filter: updatedFilter);

      final params = GetShippingInvoicesListUseCaseParams(paginationFilterDTO: updatedFilterPagination);

      final either = await getShippingInvoicesListUsecase.call(params);
      emit(state.copyWith(loading: false));

      either.fold(
        (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
        (shippingInvoices) {
          emit(state.copyWith(
            shippingInvoicesList: shippingInvoices,
            paginationFilterDTO: updatedFilterPagination,
            totalCount: totalCount,
          ));
        },
      );
    }
  }

  onAddedUpdatedShippingInvoice(AddedUpdatedShippingInvoiceEvent event, Emitter<ShippingInvoicesListState> emit) async {
    final state = this.state as ShippingInvoicesListLoaded;
    final params = GetShippingInvoicesListUseCaseParams(paginationFilterDTO: state.paginationFilterDTO);
    emit(state.copyWith(loading: true));
    final either = await getShippingInvoicesListUsecase.call(params);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
      (shippingInvoices) => emit(state.copyWith(
        totalCount: totalCount,
        shippingInvoicesList: shippingInvoices,
      )),
    );
  }
}
