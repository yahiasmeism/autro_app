import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/features/customers/domin/repositories/customers_repository.dart';
import 'package:autro_app/features/customers/domin/usecases/create_customer_usecase.dart';
import 'package:autro_app/features/customers/domin/usecases/delete_customer_usecase.dart';
import 'package:autro_app/features/customers/domin/usecases/get_customers_list_usecase.dart';
import 'package:autro_app/features/customers/domin/usecases/update_customer_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/common/domin/dto/pagination_query_payload_dto.dart';
import '../../../domin/entities/customer_entity.dart';

part 'customers_list_event.dart';
part 'customers_list_state.dart';

@lazySingleton
class CustomersListBloc extends Bloc<CustomersListEvent, CustomersListState> {
  final GetCustomersListUsecase getCustomersListUsecase;
  final DeleteCustomerUsecase deleteCustomerUsecase;
  final CustomersRepository customersRepository;
  final UpdateCustomerUsecase updateCustomerUsecase;
  final CreateCustomerUsecase createCustomerUsecase;
  CustomersListBloc(
    this.getCustomersListUsecase,
    this.customersRepository,
    this.deleteCustomerUsecase,
    this.updateCustomerUsecase,
    this.createCustomerUsecase,
  ) : super(CustomersListInitial()) {
    on<CustomersListEvent>(_mapEvents);
  }

  int get totalCount => customersRepository.totalCount;

  Future _mapEvents(CustomersListEvent event, Emitter<CustomersListState> emit) async {
    if (event is GetCustomersListEvent) {
      await onGetCustomersList(event, emit);
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
    if (event is DeleteCustomerEvent) {
      await onDeleteCustomer(event, emit);
    }
    if (event is SearchInputChangedEvent) {
      await onSearchInputChanged(event, emit);
    }
    if (event is AddedUpdatedCustomerEvent) {
      await onAddedUpdatedCustomer(event, emit);
    }
  }

  Future onGetCustomersList(GetCustomersListEvent event, Emitter<CustomersListState> emit) async {
    emit(CustomersListInitial());
    final paginationFilterDto = PaginationFilterDTO.initial();
    final params = GetCustomersListUsecaseParams(dto: paginationFilterDto);
    final either = await getCustomersListUsecase.call(params);
    either.fold(
      (failure) => emit(CustomersListError(failure: failure)),
      (customers) => emit(CustomersListLoaded(
        totalCount: totalCount,
        customersList: customers,
        paginationFilterDTO: paginationFilterDto,
      )),
    );
  }

  Future onUpdatePagination(OnUpdatePaginationEvent event, Emitter<CustomersListState> emit) async {
    final state = this.state as CustomersListLoaded;
    final paginationFilterDto = state.paginationFilterDTO.copyWith(pageNumber: event.pageNumber);
    final params = GetCustomersListUsecaseParams(dto: paginationFilterDto);

    emit(state.copyWith(loadingPagination: true));
    final either = await getCustomersListUsecase.call(params);
    emit(state.copyWith(loadingPagination: false));
    either.fold(
      (failure) => emit(CustomersListError(failure: failure)),
      (customers) => emit(CustomersListLoaded(
        totalCount: totalCount,
        customersList: customers,
        paginationFilterDTO: paginationFilterDto,
      )),
    );
  }

  onHandleFailure(HandleFailureEvent event, Emitter<CustomersListState> emit) async {
    emit(CustomersListInitial());
    await Future.delayed(const Duration(milliseconds: 300));
    add(GetCustomersListEvent());
  }

  onNextPage(NextPageEvent event, Emitter<CustomersListState> emit) {
    final state = this.state as CustomersListLoaded;
    final pageNumber = state.paginationFilterDTO.pageNumber + 1;
    add(OnUpdatePaginationEvent(pageNumber: pageNumber));
  }

  onPreviousPage(PreviousPageEvent event, Emitter<CustomersListState> emit) {
    final state = this.state as CustomersListLoaded;
    final pageNumber = state.paginationFilterDTO.pageNumber - 1;
    add(OnUpdatePaginationEvent(pageNumber: pageNumber));
  }

  onDeleteCustomer(DeleteCustomerEvent event, Emitter<CustomersListState> emit) async {
    final state = this.state as CustomersListLoaded;
    emit(state.copyWith(loading: true));
    final either = await deleteCustomerUsecase.call(event.customerId);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
      (_) {
        final updatedCustomersList = List.of(state.customersList);
        updatedCustomersList.removeWhere((element) => element.id == event.customerId);
        const message = 'Customer Deleted Successfully';
        emit(state.copyWith(
          customersList: updatedCustomersList,
          failureOrSuccessOption: some(right(message)),
          totalCount: totalCount - 1,
        ));
      },
    );
  }

  onSearchInputChanged(SearchInputChangedEvent event, Emitter<CustomersListState> emit) async {
    final state = this.state as CustomersListLoaded;

    emit(state.copyWith(loading: true));

    final conditions = List.of(state.paginationFilterDTO.filter.conditions);

    final newCondition = FilterConditionDTO.searchFilter(event.keyword);

    conditions.removeWhere((condition) => condition.fieldName == newCondition.fieldName);
    if (event.keyword.isNotEmpty) conditions.add(newCondition);

    final updatedFilter = state.paginationFilterDTO.filter.copyWith(conditions: conditions);

    final updatedFilterPagination = PaginationFilterDTO.initial().copyWith(filter: updatedFilter);

    final params = GetCustomersListUsecaseParams(dto: updatedFilterPagination);

    final either = await getCustomersListUsecase.call(params);
    emit(state.copyWith(loading: false));

    either.fold(
      (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
      (customers) {
        emit(state.copyWith(
          customersList: customers,
          paginationFilterDTO: updatedFilterPagination,
          totalCount: totalCount,
        ));
      },
    );
  }

  onAddedUpdatedCustomer(AddedUpdatedCustomerEvent event, Emitter<CustomersListState> emit) async {
    final state = this.state as CustomersListLoaded;
    final params = GetCustomersListUsecaseParams(dto: state.paginationFilterDTO);
    emit(state.copyWith(loading: true));
    final either = await getCustomersListUsecase.call(params);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit(CustomersListError(failure: failure)),
      (customers) => emit(state.copyWith(
        totalCount: totalCount,
        customersList: customers,
      )),
    );
  }
}
