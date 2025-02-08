part of 'shipping_invoice_form_bloc.dart';

sealed class ShippingInvoiceFormState extends Equatable {
  const ShippingInvoiceFormState();

  @override
  List<Object?> get props => [];
}

final class ShippingInvoiceInfoInitial extends ShippingInvoiceFormState {}

final class ShippingInvoiceFormLoaded extends ShippingInvoiceFormState {
  final ShippingInvoiceEntity? shippingInvoice;
  final Option<File> pickedAttachment;
  final Option<String> attachmentUrl;
  final bool loading;
  final Option<Either<Failure, String>> failureOrSuccessOption;
  final bool updatedMode;
  final bool saveEnabled;
  final bool cancelEnabled;
  final bool clearEnabled;
  const ShippingInvoiceFormLoaded({
    this.pickedAttachment = const None(),
    this.shippingInvoice,
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
        shippingInvoice,
        loading,
        failureOrSuccessOption,
        updatedMode,
        saveEnabled,
        cancelEnabled,
        clearEnabled,
        pickedAttachment,
        attachmentUrl,
      ];

  bool get shippingInvoiceHasImageAttachment {
    final attachmentUrl = this.attachmentUrl.fold(() => '', (r) => r);
    if (attachmentUrl.isEmpty) return false;
    return attachmentUrl.split('.').last == 'jpg' ||
        attachmentUrl.split('.').last == 'png' ||
        attachmentUrl.split('.').last == 'jpeg';
  }

  bool get shippingInvoiceHasPdfAttachment {
    final attachmentUrl = this.attachmentUrl.fold(() => '', (r) => r);
    if (attachmentUrl.isEmpty) return false;
    return attachmentUrl.split('.').last == 'pdf';
  }

  ShippingInvoiceFormLoaded copyWith({
    ShippingInvoiceEntity? shippingInvoice,
    bool? clearEnabled,
    bool? updatedMode,
    bool? saveEnabled,
    bool? cancelEnabled,
    bool? loading,
    Option<File>? pickedAttachment,
    Option<String>? attachmentUrl,
    Option<Either<Failure, String>>? failureOrSuccessOption,
  }) {
    return ShippingInvoiceFormLoaded(
      attachmentUrl: attachmentUrl ?? this.attachmentUrl,
      updatedMode: updatedMode ?? this.updatedMode,
      shippingInvoice: shippingInvoice ?? this.shippingInvoice,
      saveEnabled: saveEnabled ?? this.saveEnabled,
      cancelEnabled: cancelEnabled ?? this.cancelEnabled,
      clearEnabled: clearEnabled ?? this.clearEnabled,
      loading: loading ?? this.loading,
      failureOrSuccessOption: failureOrSuccessOption ?? none(),
      pickedAttachment: pickedAttachment ?? this.pickedAttachment,
    );
  }
}

class ShippingInvoiceFormError extends ShippingInvoiceFormState {
  final Failure failure;
  final int id;

  const ShippingInvoiceFormError({required this.failure, required this.id});

  @override
  List<Object?> get props => [failure, id];
}
