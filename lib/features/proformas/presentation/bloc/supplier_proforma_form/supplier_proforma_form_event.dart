part of 'supplier_proforma_form_bloc.dart';

sealed class SupplierProformaFormEvent extends Equatable {
  const SupplierProformaFormEvent();

  @override
  List<Object?> get props => [];
}

class InitialSupplierProformaFormEvent extends SupplierProformaFormEvent {
  final SupplierProformaEntity? supplierProforma;
  const InitialSupplierProformaFormEvent({this.supplierProforma});

  @override
  List<Object?> get props => [supplierProforma];
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