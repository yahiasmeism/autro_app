part of 'supplier_form_bloc.dart';

sealed class SupplierFormEvent extends Equatable {
  const SupplierFormEvent();

  @override
  List<Object?> get props => [];
}

class InitialSupplierFormEvent extends SupplierFormEvent {
  final SupplierEntity? supplier;
  const InitialSupplierFormEvent({this.supplier});

  @override
  List<Object?> get props => [supplier];
}

final class SubmitSupplierFormEvent extends SupplierFormEvent {}

final class UpdateSupplierFormEvent extends SupplierFormEvent {}

class CreateSupplierFormEvent extends SupplierFormEvent {}

class SupplierFormChangedEvent extends SupplierFormEvent {}


class ClearSupplierFormEvent extends SupplierFormEvent {}

class CancelSupplierFormEvent extends SupplierFormEvent {}