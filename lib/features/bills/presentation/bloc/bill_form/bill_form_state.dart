part of 'bill_form_bloc.dart';

sealed class BillFormState extends Equatable {
  const BillFormState();

  @override
  List<Object?> get props => [];
}

final class BillInfoInitial extends BillFormState {}

final class BillFormLoaded extends BillFormState {
  final BillEntity? bill;
  final bool loading;
  final Option<Either<Failure, String>> failureOrSuccessOption;
  final bool updatedMode;
  final bool saveEnabled;
  final bool cancelEnabled;
  final bool clearEnabled;
  const BillFormLoaded({
    this.bill,
    this.loading = false,
    this.failureOrSuccessOption = const None(),
    this.updatedMode = false,
    this.saveEnabled = false,
    this.cancelEnabled = false,
    this.clearEnabled = false,
  });
  @override
  List<Object?> get props => [bill, loading, failureOrSuccessOption, updatedMode, saveEnabled, cancelEnabled, clearEnabled];

  BillFormLoaded copyWith({
    BillEntity? bill,
    bool? clearEnabled,
    bool? updatedMode,
    bool? saveEnabled,
    bool? cancelEnabled,
    bool? loading,
    Option<Either<Failure, String>>? failureOrSuccessOption,
  }) {
    return BillFormLoaded(
      updatedMode: updatedMode ?? this.updatedMode,
      bill: bill ?? this.bill,
      saveEnabled: saveEnabled ?? this.saveEnabled,
      cancelEnabled: cancelEnabled ?? this.cancelEnabled,
      clearEnabled: clearEnabled ?? this.clearEnabled,
      loading: loading ?? this.loading,
      failureOrSuccessOption: failureOrSuccessOption ?? none(),
    );
  }
}

class BillFormError extends BillFormState {
  final Failure failure;
  final int id;

  const BillFormError({required this.failure, required this.id});

  @override
  List<Object?> get props => [failure, id];
}
