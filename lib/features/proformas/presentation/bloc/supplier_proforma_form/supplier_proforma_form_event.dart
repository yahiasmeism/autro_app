part of 'supplier_proforma_form_bloc.dart';

sealed class SupplierProformaFormEvent extends Equatable {
  const SupplierProformaFormEvent();

  @override
  List<Object?> get props => [];
}

class InitialSupplierProformaFormEvent extends SupplierProformaFormEvent {
  final int? supplierProformaId;
  const InitialSupplierProformaFormEvent({this.supplierProformaId});

  @override
  List<Object?> get props => [supplierProformaId];
}

final class SubmitSupplierProformaFormEvent extends SupplierProformaFormEvent {}

final class UpdateSupplierProformaFormEvent extends SupplierProformaFormEvent {}

class CreateSupplierProformaFormEvent extends SupplierProformaFormEvent {}

class SupplierProformaFormChangedEvent extends SupplierProformaFormEvent {}


class ClearSupplierProformaFormEvent extends SupplierProformaFormEvent {}

class CancelSupplierProformaFormEvent extends SupplierProformaFormEvent {}

class PickAttachmentEvent extends SupplierProformaFormEvent {
  final File file;
  const PickAttachmentEvent({required this.file});

  @override
  List<Object?> get props => [file];
}

class ClearAttachmentEvent extends SupplierProformaFormEvent {}


class SupplierProformaHandleFailure extends SupplierProformaFormEvent{}