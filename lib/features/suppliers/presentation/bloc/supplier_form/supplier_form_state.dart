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
  final FormType formType;
  const SupplierFormLoaded({
    this.supplier,
    this.loading = false,
    this.failureOrSuccessOption = const None(),
    this.formType = FormType.create,
  });
  @override
  List<Object?> get props => [supplier, loading, failureOrSuccessOption, formType];

  SupplierFormLoaded copyWith({
    SupplierEntity? supplier,
    bool? loading,
    Option<Either<Failure, String>>? failureOrSuccessOption,
    FormType? formType,
  }) {
    return SupplierFormLoaded(
      supplier: supplier ?? this.supplier,
      loading: loading ?? this.loading,
      failureOrSuccessOption: failureOrSuccessOption ?? none(),
      formType: formType ?? this.formType,
    );
  }
}
