part of 'customer_form_bloc.dart';

sealed class CustomerFormState extends Equatable {
  const CustomerFormState();

  @override
  List<Object?> get props => [];
}

final class CustomerInfoInitial extends CustomerFormState {}

final class CustomerFormLoaded extends CustomerFormState {
  final CustomerEntity? customer;
  final bool loading;
  final Option<Either<Failure, String>> failureOrSuccessOption;
  final FormType formType;
  const CustomerFormLoaded({
    this.customer,
    this.loading = false,
    this.failureOrSuccessOption = const None(),
    this.formType = FormType.create,
  });
  @override
  List<Object?> get props => [customer, loading, failureOrSuccessOption, formType];

  CustomerFormLoaded copyWith({
    CustomerEntity? customer,
    bool? loading,
    Option<Either<Failure, String>>? failureOrSuccessOption,
    FormType? formType,
  }) {
    return CustomerFormLoaded(
      customer: customer ?? this.customer,
      loading: loading ?? this.loading,
      failureOrSuccessOption: failureOrSuccessOption ?? none(),
      formType: formType ?? this.formType,
    );
  }
}
