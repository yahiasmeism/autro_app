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
  final bool updatedMode;
  final bool saveEnabled;
  final bool cancelEnabled;
  final bool clearEnabled;
  const CustomerFormLoaded({
    this.customer,
    this.loading = false,
    this.failureOrSuccessOption = const None(),
    this.updatedMode = false,
    this.saveEnabled = false,
    this.cancelEnabled = false,
    this.clearEnabled = false,
  });
  @override
  List<Object?> get props => [customer, loading, failureOrSuccessOption, updatedMode, saveEnabled, cancelEnabled,clearEnabled];

  CustomerFormLoaded copyWith({
    CustomerEntity? customer,
    bool? clearEnabled,
    bool? updatedMode,
    bool? saveEnabled,
    bool? cancelEnabled,
    bool? loading,
    Option<Either<Failure, String>>? failureOrSuccessOption,
  }) {
    return CustomerFormLoaded(
      updatedMode: updatedMode ?? this.updatedMode,
      customer: customer ?? this.customer,
      saveEnabled: saveEnabled ?? this.saveEnabled,
      cancelEnabled: cancelEnabled ?? this.cancelEnabled,
      clearEnabled: clearEnabled ?? this.clearEnabled,
      loading: loading ?? this.loading,
      failureOrSuccessOption: failureOrSuccessOption ?? none(),
    );
  }
}
