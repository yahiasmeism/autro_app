part of 'bill_form_bloc.dart';

sealed class BillFormEvent extends Equatable {
  const BillFormEvent();

  @override
  List<Object?> get props => [];
}

class InitialBillFormEvent extends BillFormEvent {
  final BillEntity? bill;
  const InitialBillFormEvent({this.bill});

  @override
  List<Object?> get props => [bill];
}

final class SubmitBillFormEvent extends BillFormEvent {}

final class UpdateBillFormEvent extends BillFormEvent {}

class CreateBillFormEvent extends BillFormEvent {}

class BillFormChangedEvent extends BillFormEvent {}


class ClearBillFormEvent extends BillFormEvent {}

class CancelBillFormEvent extends BillFormEvent {}