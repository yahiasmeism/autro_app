part of 'supplier_invoice_form_bloc.dart';

sealed class SupplierInvoiceFormState extends Equatable {
  const SupplierInvoiceFormState();

  @override
  List<Object?> get props => [];
}

final class SupplierInvoiceInfoInitial extends SupplierInvoiceFormState {}

final class SupplierInvoiceFormLoaded extends SupplierInvoiceFormState {
  final SupplierInvoiceEntity? supplierInvoice;
  final Option<File> pickedAttachment;
  final Option<String> attachmentUrl;
  final bool loading;
  final Option<Either<Failure, String>> failureOrSuccessOption;
  final bool updatedMode;
  final bool saveEnabled;
  final bool cancelEnabled;
  final bool clearEnabled;
  const SupplierInvoiceFormLoaded({
    this.pickedAttachment = const None(),
    this.supplierInvoice,
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
        supplierInvoice,
        loading,
        failureOrSuccessOption,
        updatedMode,
        saveEnabled,
        cancelEnabled,
        clearEnabled,
        pickedAttachment,
        attachmentUrl,
      ];

  bool get supplierInvoiceHasImageAttachment {
    final attachmentUrl = this.attachmentUrl.fold(() => '', (r) => r);
    if (attachmentUrl.isEmpty) return false;
    return attachmentUrl.split('.').last == 'jpg' ||
        attachmentUrl.split('.').last == 'png' ||
        attachmentUrl.split('.').last == 'jpeg';
  }

  bool get supplierInvoiceHasPdfAttachment {
    final attachmentUrl = this.attachmentUrl.fold(() => '', (r) => r);
    if (attachmentUrl.isEmpty) return false;
    return attachmentUrl.split('.').last == 'pdf';
  }

  SupplierInvoiceFormLoaded copyWith({
    SupplierInvoiceEntity? supplierInvoice,
    bool? clearEnabled,
    bool? updatedMode,
    bool? saveEnabled,
    bool? cancelEnabled,
    bool? loading,
    Option<File>? pickedAttachment,
    Option<String>? attachmentUrl,
    Option<Either<Failure, String>>? failureOrSuccessOption,
  }) {
    return SupplierInvoiceFormLoaded(
      attachmentUrl: attachmentUrl ?? this.attachmentUrl,
      updatedMode: updatedMode ?? this.updatedMode,
      supplierInvoice: supplierInvoice ?? this.supplierInvoice,
      saveEnabled: saveEnabled ?? this.saveEnabled,
      cancelEnabled: cancelEnabled ?? this.cancelEnabled,
      clearEnabled: clearEnabled ?? this.clearEnabled,
      loading: loading ?? this.loading,
      failureOrSuccessOption: failureOrSuccessOption ?? none(),
      pickedAttachment: pickedAttachment ?? this.pickedAttachment,
    );
  }
}
