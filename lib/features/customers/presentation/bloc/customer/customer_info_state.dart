part of 'customer_info_bloc.dart';

sealed class CustomerInfoState extends Equatable {
  const CustomerInfoState();

  @override
  List<Object?> get props => [];
}

final class CustomerInfoInitial extends CustomerInfoState {}

final class CustomerInfoLoaded extends CustomerInfoState {
  final CustomerEntity? customer;
  final bool loading;
  final Option<Either<Failure, String>> failureOrSuccessOption;
  final FormType formType;
  const CustomerInfoLoaded({
    this.customer,
    this.loading = false,
    this.failureOrSuccessOption = const None(),
    this.formType = FormType.create,
  });

  bool get readOnly => formType == FormType.view;
  @override
  List<Object?> get props => [customer, loading, failureOrSuccessOption, formType];

  CustomerInfoLoaded copyWith({
    CustomerEntity? customer,
    bool? loading,
    Option<Either<Failure, String>>? failureOrSuccessOption,
    FormType? formType,
  }) {
    return CustomerInfoLoaded(
      customer: customer ?? this.customer,
      loading: loading ?? this.loading,
      failureOrSuccessOption: failureOrSuccessOption ?? none(),
      formType: formType ?? this.formType,
    );
  }
}
