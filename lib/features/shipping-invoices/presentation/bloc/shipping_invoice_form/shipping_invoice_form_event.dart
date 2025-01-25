part of 'shipping_invoice_form_bloc.dart';

sealed class ShippingInvoiceFormEvent extends Equatable {
  const ShippingInvoiceFormEvent();

  @override
  List<Object?> get props => [];
}

class InitialShippingInvoiceFormEvent extends ShippingInvoiceFormEvent {
  final ShippingInvoiceEntity? shippingInvoice;
  const InitialShippingInvoiceFormEvent({this.shippingInvoice});

  @override
  List<Object?> get props => [shippingInvoice];
}

final class SubmitShippingInvoiceFormEvent extends ShippingInvoiceFormEvent {}

final class UpdateShippingInvoiceFormEvent extends ShippingInvoiceFormEvent {}

class CreateShippingInvoiceFormEvent extends ShippingInvoiceFormEvent {}

class ShippingInvoiceFormChangedEvent extends ShippingInvoiceFormEvent {}


class ClearShippingInvoiceFormEvent extends ShippingInvoiceFormEvent {}

class CancelShippingInvoiceFormEvent extends ShippingInvoiceFormEvent {}

class PickAttachmentEvent extends ShippingInvoiceFormEvent {
  final File file;
  const PickAttachmentEvent({required this.file});

  @override
  List<Object?> get props => [file];
}

class ClearAttachmentEvent extends ShippingInvoiceFormEvent {}