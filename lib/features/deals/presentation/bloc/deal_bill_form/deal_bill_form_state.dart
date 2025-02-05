part of 'deal_bill_form_bloc.dart';

sealed class DealBillFormState extends Equatable {
  const DealBillFormState();

  @override
  List<Object?> get props => [];
}

final class DealBillInfoInitial extends DealBillFormState {}

final class DealBillFormLoaded extends DealBillFormState {
  final DealBillEntity? dealBill;
  final int dealId;
  final Option<File> pickedAttachment;
  final Option<String> attachmentUrl;
  final bool loading;
  final Option<Either<Failure, String>> failureOrSuccessOption;
  final bool updatedMode;
  final bool saveEnabled;
  final bool cancelEnabled;
  final bool clearEnabled;
  const DealBillFormLoaded({
    required this.dealId,
    this.pickedAttachment = const None(),
    this.dealBill,
    this.loading = false,
    this.failureOrSuccessOption = const None(),
    this.updatedMode = false,
    this.saveEnabled = false,
    this.cancelEnabled = false,
    this.clearEnabled = false,
    this.attachmentUrl = const None(),
  });

  @override
  List<Object?> get props => [
        dealId,
        dealBill,
        loading,
        failureOrSuccessOption,
        updatedMode,
        saveEnabled,
        cancelEnabled,
        clearEnabled,
        pickedAttachment,
        attachmentUrl,
      ];

  bool get dealBillHasImageAttachment {
    final attachmentUrl = this.attachmentUrl.fold(() => '', (r) => r);
    if (attachmentUrl.isEmpty) return false;
    return attachmentUrl.split('.').last == 'jpg' ||
        attachmentUrl.split('.').last == 'png' ||
        attachmentUrl.split('.').last == 'jpeg';
  }

  bool get dealBillHasPdfAttachment {
    final attachmentUrl = this.attachmentUrl.fold(() => '', (r) => r);
    if (attachmentUrl.isEmpty) return false;
    return attachmentUrl.split('.').last == 'pdf';
  }

  DealBillFormLoaded copyWith({
    DealBillEntity? dealBill,
    bool? clearEnabled,
    bool? updatedMode,
    bool? saveEnabled,
    bool? cancelEnabled,
    bool? loading,
    Option<File>? pickedAttachment,
    Option<String>? attachmentUrl,
    int? dealId,
    Option<Either<Failure, String>>? failureOrSuccessOption,
  }) {
    return DealBillFormLoaded(
      attachmentUrl: attachmentUrl ?? this.attachmentUrl,
      updatedMode: updatedMode ?? this.updatedMode,
      dealBill: dealBill ?? this.dealBill,
      saveEnabled: saveEnabled ?? this.saveEnabled,
      cancelEnabled: cancelEnabled ?? this.cancelEnabled,
      clearEnabled: clearEnabled ?? this.clearEnabled,
      loading: loading ?? this.loading,
      failureOrSuccessOption: failureOrSuccessOption ?? none(),
      pickedAttachment: pickedAttachment ?? this.pickedAttachment,
      dealId: dealId ?? this.dealId,
    );
  }
}
