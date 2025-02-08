part of 'supplier_invoice_form_bloc.dart';

sealed class SupplierInvoiceFormEvent extends Equatable {
  const SupplierInvoiceFormEvent();

  @override
  List<Object?> get props => [];
}

class InitialSupplierInvoiceFormEvent extends SupplierInvoiceFormEvent {
  final int? id;
  const InitialSupplierInvoiceFormEvent({this.id});

  @override
  List<Object?> get props => [id];
}

final class SubmitSupplierInvoiceFormEvent extends SupplierInvoiceFormEvent {}

final class UpdateSupplierInvoiceFormEvent extends SupplierInvoiceFormEvent {}

class CreateSupplierInvoiceFormEvent extends SupplierInvoiceFormEvent {}

class SupplierInvoiceFormChangedEvent extends SupplierInvoiceFormEvent {}


class ClearSupplierInvoiceFormEvent extends SupplierInvoiceFormEvent {}

class CancelSupplierInvoiceFormEvent extends SupplierInvoiceFormEvent {}

class PickAttachmentEvent extends SupplierInvoiceFormEvent {
  final File file;
  const PickAttachmentEvent({required this.file});

  @override
  List<Object?> get props => [file];
}

class ClearAttachmentEvent extends SupplierInvoiceFormEvent {}
class SupplierInvoiceHandleError extends SupplierInvoiceFormEvent{}