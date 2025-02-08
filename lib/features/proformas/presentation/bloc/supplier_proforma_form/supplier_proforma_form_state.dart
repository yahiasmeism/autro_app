part of 'supplier_proforma_form_bloc.dart';

sealed class SupplierProformaFormState extends Equatable {
  const SupplierProformaFormState();

  @override
  List<Object?> get props => [];
}

final class SupplierProformaInfoInitial extends SupplierProformaFormState {}

final class SupplierProformaFormLoaded extends SupplierProformaFormState {
  final SupplierProformaEntity? supplierProforma;
  final Option<File> pickedAttachment;
  final Option<String> attachmentUrl;
  final bool loading;
  final Option<Either<Failure, String>> failureOrSuccessOption;
  final bool updatedMode;
  final bool saveEnabled;
  final bool cancelEnabled;
  final bool clearEnabled;
  const SupplierProformaFormLoaded({
    this.pickedAttachment = const None(),
    this.supplierProforma,
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
        supplierProforma,
        loading,
        failureOrSuccessOption,
        updatedMode,
        saveEnabled,
        cancelEnabled,
        clearEnabled,
        pickedAttachment,
        attachmentUrl,
      ];

  bool get supplierProformaHasImageAttachment {
    final attachmentUrl = this.attachmentUrl.fold(() => '', (r) => r);
    if (attachmentUrl.isEmpty) return false;
    return attachmentUrl.split('.').last == 'jpg' ||
        attachmentUrl.split('.').last == 'png' ||
        attachmentUrl.split('.').last == 'jpeg';
  }

  bool get supplierProformaHasPdfAttachment {
    final attachmentUrl = this.attachmentUrl.fold(() => '', (r) => r);
    if (attachmentUrl.isEmpty) return false;
    return attachmentUrl.split('.').last == 'pdf';
  }

  SupplierProformaFormLoaded copyWith({
    SupplierProformaEntity? supplierProforma,
    bool? clearEnabled,
    bool? updatedMode,
    bool? saveEnabled,
    bool? cancelEnabled,
    bool? loading,
    Option<File>? pickedAttachment,
    Option<String>? attachmentUrl,
    Option<Either<Failure, String>>? failureOrSuccessOption,
  }) {
    return SupplierProformaFormLoaded(
      attachmentUrl: attachmentUrl ?? this.attachmentUrl,
      updatedMode: updatedMode ?? this.updatedMode,
      supplierProforma: supplierProforma ?? this.supplierProforma,
      saveEnabled: saveEnabled ?? this.saveEnabled,
      cancelEnabled: cancelEnabled ?? this.cancelEnabled,
      clearEnabled: clearEnabled ?? this.clearEnabled,
      loading: loading ?? this.loading,
      failureOrSuccessOption: failureOrSuccessOption ?? none(),
      pickedAttachment: pickedAttachment ?? this.pickedAttachment,
    );
  }
}

class SupplierProformaFormError extends SupplierProformaFormState {
  final Failure failure;
  final int id;

  const SupplierProformaFormError({required this.failure, required this.id});

  @override
  List<Object?> get props => [failure, id];
}
