part of 'supplier_form_bloc.dart';

sealed class SupplierFormState extends Equatable {
  const SupplierFormState();

  @override
  List<Object?> get props => [];
}

final class SupplierInfoInitial extends SupplierFormState {}

final class SupplierFormLoaded extends SupplierFormState {
  final SupplierEntity? supplier;
  final bool loading;
  final Option<Either<Failure, String>> failureOrSuccessOption;
  final bool updatedMode;
  final bool saveEnabled;
  final bool cancelEnabled;
  final bool clearEnabled;
  const SupplierFormLoaded({
    this.supplier,
    this.loading = false,
    this.failureOrSuccessOption = const None(),
    this.updatedMode = false,
    this.saveEnabled = false,
    this.cancelEnabled = false,
    this.clearEnabled = false,
  });
  @override
  List<Object?> get props => [supplier, loading, failureOrSuccessOption, updatedMode, saveEnabled, cancelEnabled,clearEnabled];

  SupplierFormLoaded copyWith({
    SupplierEntity? supplier,
    bool? clearEnabled,
    bool? updatedMode,
    bool? saveEnabled,
    bool? cancelEnabled,
    bool? loading,
    Option<Either<Failure, String>>? failureOrSuccessOption,
  }) {
    return SupplierFormLoaded(
      updatedMode: updatedMode ?? this.updatedMode,
      supplier: supplier ?? this.supplier,
      saveEnabled: saveEnabled ?? this.saveEnabled,
      cancelEnabled: cancelEnabled ?? this.cancelEnabled,
      clearEnabled: clearEnabled ?? this.clearEnabled,
      loading: loading ?? this.loading,
      failureOrSuccessOption: failureOrSuccessOption ?? none(),
    );
  }
}
