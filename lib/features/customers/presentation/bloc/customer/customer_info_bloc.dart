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

part 'customer_info_event.dart';
part 'customer_info_state.dart';

@injectable
class CustomerInfoBloc extends Bloc<CustomerInfoEvent, CustomerInfoState> {
  final CreateCustomerUsecase createCustomerUsecase;
  final UpdateCustomerUsecase updateCustomerUsecase;
  final CustomersListBloc customersListBloc;
  CustomerInfoBloc(
    this.createCustomerUsecase,
    this.updateCustomerUsecase,
    this.customersListBloc,
  ) : super(CustomerInfoInitial()) {
    on<CustomerInfoEvent>(_mapEvents);
  }

  _mapEvents(CustomerInfoEvent event, Emitter<CustomerInfoState> emit) async {
    if (event is InitialCustomerInfoEvent) {
      await _initial(event, emit);
    }
    if (event is CreateCustomerEvent) {
      await _onCreateCustomer(event, emit);
    }
    if (event is UpdateCustomerEvent) {
      await _onUpdateCustomer(event, emit);
    }
  }

  _initial(InitialCustomerInfoEvent event, Emitter<CustomerInfoState> emit) {
    emit(CustomerInfoLoaded(customer: event.customer, formType: event.formType));
  }

  Future _onCreateCustomer(CreateCustomerEvent event, Emitter<CustomerInfoState> emit) async {
    final state = this.state as CustomerInfoLoaded;
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

  Future _onUpdateCustomer(UpdateCustomerEvent event, Emitter<CustomerInfoState> emit) async {
    final state = this.state as CustomerInfoLoaded;
    emit(state.copyWith(loading: true));
    final either = await updateCustomerUsecase.call(UpdateCustomerUsecaseParams(event.customer));
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit((state.copyWith(failureOrSuccessOption: some(left(failure))))),
      (customer) {
        customersListBloc.add(GetCustomersListEvent());
        emit(state.copyWith(customer: customer, failureOrSuccessOption: some(right('Customer updated'))));
      },
    );
  }
}
