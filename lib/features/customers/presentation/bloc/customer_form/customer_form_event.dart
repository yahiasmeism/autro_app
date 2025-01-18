part of 'customer_form_bloc.dart';

sealed class CustomerFormEvent extends Equatable {
  const CustomerFormEvent();

  @override
  List<Object?> get props => [];
}

class InitialCustomerFormEvent extends CustomerFormEvent {
  final CustomerEntity? customer;
  const InitialCustomerFormEvent({this.customer});

  @override
  List<Object?> get props => [customer];
}

final class SubmitCustomerFormEvent extends CustomerFormEvent {}

final class UpdateCustomerFormEvent extends CustomerFormEvent {}

class CreateCustomerFormEvent extends CustomerFormEvent {}

class CustomerFormChangedEvent extends CustomerFormEvent {}


class ClearCustomerFormEvent extends CustomerFormEvent {}

class CancelCustomerFormEvent extends CustomerFormEvent {}