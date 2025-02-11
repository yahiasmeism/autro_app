part of 'bill_form_bloc.dart';

sealed class BillFormEvent extends Equatable {
  const BillFormEvent();

  @override
  List<Object?> get props => [];
}

class InitialBillFormEvent extends BillFormEvent {
  final int? billId;
  const InitialBillFormEvent({this.billId});

  @override
  List<Object?> get props => [billId];
}

final class SubmitBillFormEvent extends BillFormEvent {}

final class UpdateBillFormEvent extends BillFormEvent {}

class CreateBillFormEvent extends BillFormEvent {}

class BillFormChangedEvent extends BillFormEvent {}

class ClearBillFormEvent extends BillFormEvent {}

class CancelBillFormEvent extends BillFormEvent {}

class BillFormHandleError extends BillFormEvent {}

class PickAttachmentEvent extends BillFormEvent {
  final File file;

  const PickAttachmentEvent({required this.file});

  @override
  List<Object?> get props => [file];
}

class RemoveAttachmentEvent extends BillFormEvent {}
