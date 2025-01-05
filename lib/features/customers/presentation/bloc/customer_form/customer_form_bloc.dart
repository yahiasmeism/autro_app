import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/features/customers/domin/entities/customer_entity.dart';
import 'package:autro_app/features/customers/presentation/bloc/customers_list/customers_list_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../domin/usecases/create_customer_usecase.dart';
import '../../../domin/usecases/update_customer_usecase.dart';

part 'customer_form_event.dart';
part 'customer_form_state.dart';

@injectable
class CustomerFormBloc extends Bloc<CustomerFormEvent, CustomerFormState> {
  final CreateCustomerUsecase createCustomerUsecase;
  final UpdateCustomerUsecase updateCustomerUsecase;
  final CustomersListBloc customersListBloc;
  CustomerFormBloc(
    this.createCustomerUsecase,
    this.updateCustomerUsecase,
    this.customersListBloc,
  ) : super(CustomerInfoInitial()) {
    on<CustomerFormEvent>(_mapEvents);
  }

  _mapEvents(CustomerFormEvent event, Emitter<CustomerFormState> emit) async {
    if (event is InitialCustomerFormEvent) {
      await _initial(event, emit);
    }
    if (event is CreateCustomerFormEvent) {
      await _onCreateCustomer(event, emit);
    }
    if (event is UpdateCustomerFormEvent) {
      await _onUpdateCustomer(event, emit);
    }
  }

  _initial(InitialCustomerFormEvent event, Emitter<CustomerFormState> emit) {
    emit(CustomerFormLoaded(customer: event.customer, formType: event.formType));
  }

  Future _onCreateCustomer(CreateCustomerFormEvent event, Emitter<CustomerFormState> emit) async {
    final state = this.state as CustomerFormLoaded;
    emit(state.copyWith(loading: true));

    final either = await createCustomerUsecase.call(event.toParams());
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit(
        (state.copyWith(
          failureOrSuccessOption: some(left(failure)),
          customer: state.customer,
        )),
      ),
      (customer) {
        customersListBloc.add(GetCustomersListEvent());
        emit(state.copyWith(customer: customer, failureOrSuccessOption: some(right('Customer created'))));
      },
    );
  }

  Future _onUpdateCustomer(UpdateCustomerFormEvent event, Emitter<CustomerFormState> emit) async {
    final state = this.state as CustomerFormLoaded;
    final customerEntity = state.customer?.copyWith();
    if (customerEntity == event.customer) {
      emit(state.copyWith(failureOrSuccessOption: some(right(''))));
      return;
    }
    emit(state.copyWith(loading: true));
    final either = await updateCustomerUsecase.call(UpdateCustomerUsecaseParams(event.customer));
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit((state.copyWith(failureOrSuccessOption: some(left(failure))))),
      (customer) {
        customersListBloc.add(AddedUpdatedCustomerEvent());
        emit(state.copyWith(customer: customer, failureOrSuccessOption: some(right('Customer updated'))));
      },
    );
  }
}
