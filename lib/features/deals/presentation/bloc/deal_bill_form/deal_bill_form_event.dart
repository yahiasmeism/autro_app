part of 'deal_bill_form_bloc.dart';

sealed class DealBillFormEvent extends Equatable {
  const DealBillFormEvent();

  @override
  List<Object?> get props => [];
}

class InitialDealBillFormEvent extends DealBillFormEvent {
  final int dealId;
  final DealBillEntity? dealBill;
  const InitialDealBillFormEvent({this.dealBill, required this.dealId});
  

  @override
  List<Object?> get props => [dealBill, dealId];
}

final class SubmitDealBillFormEvent extends DealBillFormEvent {}

final class UpdateDealBillFormEvent extends DealBillFormEvent {}

class CreateDealBillFormEvent extends DealBillFormEvent {}

class DealBillFormChangedEvent extends DealBillFormEvent {}


class ClearDealBillFormEvent extends DealBillFormEvent {}

class CancelDealBillFormEvent extends DealBillFormEvent {}

class PickAttachmentEvent extends DealBillFormEvent {
  final File file;
  const PickAttachmentEvent({required this.file});

  @override
  List<Object?> get props => [file];
}

class ClearAttachmentEvent extends DealBillFormEvent {}