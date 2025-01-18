import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/extensions/primary_contact_type_extension.dart';
import 'package:autro_app/features/customers/domin/entities/customer_entity.dart';
import 'package:autro_app/features/customers/presentation/bloc/customers_list/customers_list_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
    if (event is SubmitCustomerFormEvent) {
      await _onSubmitCustomer(event, emit);
    }
    if (event is UpdateCustomerFormEvent) {
      await _onUpdateCustomer(event, emit);
    }
    if (event is CreateCustomerFormEvent) {
      await _onCreateCustomer(event, emit);
    }

    if (event is CustomerFormChangedEvent) {
      await _onCustomerFormChanged(event, emit);
    }
    if (event is CancelCustomerFormEvent) {
      await _onCancelCustomerFormEvent(event, emit);
    }
    if (event is ClearCustomerFormEvent) {
      await _onClearCustomerForm(event, emit);
    }
  }

  final nameController = TextEditingController();
  final primaryContactController = TextEditingController();
  final country = TextEditingController();
  final city = TextEditingController();
  final website = TextEditingController();
  final businessDetails = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final altPhone = TextEditingController();
  final notes = TextEditingController();
  final formKey = GlobalKey<FormState>();

  _initial(InitialCustomerFormEvent event, Emitter<CustomerFormState> emit) {
    emit(CustomerFormLoaded(customer: event.customer, updatedMode: event.customer != null));
    _initializeControllers();
  }

  _initializeControllers() {
    final state = this.state as CustomerFormLoaded;
    formKey.currentState?.reset();
    nameController.text = state.customer?.name ?? '';
    country.text = state.customer?.country ?? '';
    city.text = state.customer?.city ?? '';
    website.text = state.customer?.website ?? '';
    businessDetails.text = state.customer?.businessDetails ?? '';
    email.text = state.customer?.email ?? '';
    phone.text = state.customer?.phone ?? '';
    altPhone.text = state.customer?.altPhone ?? '';
    primaryContactController.text = state.customer?.primaryContactType.str ?? '';
    notes.text = state.customer?.notes ?? '';
    setupControllersListeners();
    add(CustomerFormChangedEvent());
  }

  setupControllersListeners() {
    nameController.addListener(() => add(CustomerFormChangedEvent()));
    country.addListener(() => add(CustomerFormChangedEvent()));
    city.addListener(() => add(CustomerFormChangedEvent()));
    website.addListener(() => add(CustomerFormChangedEvent()));
    businessDetails.addListener(() => add(CustomerFormChangedEvent()));
    email.addListener(() => add(CustomerFormChangedEvent()));
    phone.addListener(() => add(CustomerFormChangedEvent()));
    altPhone.addListener(() => add(CustomerFormChangedEvent()));
    primaryContactController.addListener(() => add(CustomerFormChangedEvent()));
    notes.addListener(() => add(CustomerFormChangedEvent()));
  }

  _onCustomerFormChanged(CustomerFormChangedEvent event, Emitter<CustomerFormState> emit) {
    final state = this.state as CustomerFormLoaded;
    final formIsNotEmpty = nameController.text.isNotEmpty ||
        country.text.isNotEmpty ||
        city.text.isNotEmpty ||
        website.text.isNotEmpty ||
        businessDetails.text.isNotEmpty ||
        email.text.isNotEmpty ||
        phone.text.isNotEmpty ||
        altPhone.text.isNotEmpty ||
        primaryContactController.text.isNotEmpty ||
        notes.text.isNotEmpty;

    if (state.updatedMode) {
      final customer = state.customer!;
      bool isFormChanged = customer.name != nameController.text ||
          customer.country != country.text ||
          customer.city != city.text ||
          customer.website != website.text ||
          customer.businessDetails != businessDetails.text ||
          customer.email != email.text ||
          customer.phone != phone.text ||
          customer.altPhone != altPhone.text ||
          customer.primaryContactType.str.toLowerCase() != primaryContactController.text.toLowerCase() ||
          customer.notes != notes.text;
      emit(state.copyWith(
          saveEnabled: formIsNotEmpty && isFormChanged, cancelEnabled: isFormChanged, clearEnabled: formIsNotEmpty));
    } else {
      emit(state.copyWith(saveEnabled: formIsNotEmpty, cancelEnabled: false, clearEnabled: formIsNotEmpty));
    }
  }

  _onSubmitCustomer(SubmitCustomerFormEvent event, Emitter<CustomerFormState> emit) {
    final state = this.state as CustomerFormLoaded;
    if (formKey.currentState?.validate() == false) return;
    if (state.updatedMode) {
      add(UpdateCustomerFormEvent());
    } else {
      add(CreateCustomerFormEvent());
    }
  }

  Future _onCreateCustomer(CreateCustomerFormEvent event, Emitter<CustomerFormState> emit) async {
    final state = this.state as CustomerFormLoaded;
    emit(state.copyWith(loading: true));

    final params = CreateCustomerUsecaseParams(
      name: nameController.text,
      country: country.text,
      city: city.text,
      website: website.text,
      businessDetails: businessDetails.text,
      email: email.text,
      phone: phone.text,
      altPhone: altPhone.text,
      primaryContactType: PrimaryContactTypeX.fromString(primaryContactController.text),
      notes: notes.text,
    );

    final either = await createCustomerUsecase.call(params);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit(
        (state.copyWith(
          failureOrSuccessOption: some(left(failure)),
          customer: state.customer,
        )),
      ),
      (customer) {
        customersListBloc.add(AddedUpdatedCustomerEvent());
        emit(state.copyWith(customer: customer, failureOrSuccessOption: some(right('Customer created'))));
      },
    );
  }

  Future _onUpdateCustomer(UpdateCustomerFormEvent event, Emitter<CustomerFormState> emit) async {
    final state = this.state as CustomerFormLoaded;

    final updatedCustomer = state.customer!.copyWith(
      name: nameController.text,
      country: country.text,
      city: city.text,
      website: website.text,
      businessDetails: businessDetails.text,
      email: email.text,
      phone: phone.text,
      altPhone: altPhone.text,
      primaryContactType: PrimaryContactTypeX.fromString(primaryContactController.text),
      notes: notes.text,
    );

    emit(state.copyWith(loading: true));
    final either = await updateCustomerUsecase.call(UpdateCustomerUsecaseParams(updatedCustomer));
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit((state.copyWith(failureOrSuccessOption: some(left(failure))))),
      (customer) {
        customersListBloc.add(AddedUpdatedCustomerEvent());
        emit(state.copyWith(customer: customer, failureOrSuccessOption: some(right('Customer updated'))));
        _initializeControllers();
      },
    );
  }

  _onClearCustomerForm(ClearCustomerFormEvent event, Emitter<CustomerFormState> emit) {
    formKey.currentState?.reset();
    nameController.clear();
    country.clear();
    city.clear();
    website.clear();
    businessDetails.clear();
    email.clear();
    phone.clear();
    altPhone.clear();
    primaryContactController.clear();
    notes.clear();
  }

  _onCancelCustomerFormEvent(CustomerFormEvent event, Emitter<CustomerFormState> emit) => _initializeControllers();

  @override
  Future<void> close() {
    nameController.dispose();
    country.dispose();
    city.dispose();
    website.dispose();
    businessDetails.dispose();
    email.dispose();
    phone.dispose();
    altPhone.dispose();
    primaryContactController.dispose();
    notes.dispose();
    return super.close();
  }
}
