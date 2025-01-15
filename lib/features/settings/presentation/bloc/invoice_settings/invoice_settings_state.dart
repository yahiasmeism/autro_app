part of 'invoice_settings_cubit.dart';

sealed class InvoiceSettingsState extends Equatable {
  const InvoiceSettingsState();

  @override
  List<Object> get props => [];
}

final class InvoiceSettingsInitial extends InvoiceSettingsState {}

final class InvoiceSettingsLoaded extends InvoiceSettingsState {
  final bool loading;
  final InvoiceSettingsEntity invoiceSettings;
  final Option<Either<Failure, String>> failureOrSuccessOption;
  final bool dataChanged;
  const InvoiceSettingsLoaded(
      {required this.invoiceSettings, required this.dataChanged, required this.loading, required this.failureOrSuccessOption});

  const InvoiceSettingsLoaded.initial(InvoiceSettingsEntity invoiceSettings)
      : this(
          loading: false,
          failureOrSuccessOption: const None(),
          dataChanged: false,
          invoiceSettings: invoiceSettings,
        );

  @override
  List<Object> get props => [loading, failureOrSuccessOption, dataChanged, invoiceSettings];

  InvoiceSettingsLoaded copyWith({
    bool? loading,
    Option<Either<Failure, String>>? failureOrSuccessOption,
    bool? dataChanged,
    InvoiceSettingsEntity? invoiceSettings,
  }) {
    return InvoiceSettingsLoaded(
        invoiceSettings: invoiceSettings ?? this.invoiceSettings,
        loading: loading ?? this.loading,
        failureOrSuccessOption: failureOrSuccessOption ?? none(),
        dataChanged: dataChanged ?? this.dataChanged);
  }
}

class InvoiceSettingsError extends InvoiceSettingsState {
  final Failure failure;
  const InvoiceSettingsError({required this.failure});
}
