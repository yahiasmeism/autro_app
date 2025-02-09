part of 'customer_invoice_form_cubit.dart';

sealed class CustomerInvoiceFormState extends Equatable {
  const CustomerInvoiceFormState();

  @override
  List<Object?> get props => [];
}

final class CustomerInvoiceFormInitial extends CustomerInvoiceFormState {}

final class CustomerInvoiceFormLoaded extends CustomerInvoiceFormState {
  final CustomerInvoiceEntity? invoice;
  final bool loading;
  final Option<Either<Failure, String>> failureOrSuccessOption;
  final bool updatedMode;
  final bool saveEnabled;
  final bool addGoodDescriptionEnabled;
  final bool cancelEnabled;
  final bool clearEnabled;
  final InvoicePdfDto? invoicePdfDto;
  final List<InvoiceGoodDescriptionDto> goodDescriptionsList;
  const CustomerInvoiceFormLoaded({
    this.invoice,
    this.loading = false,
    this.failureOrSuccessOption = const None(),
    this.updatedMode = false,
    this.saveEnabled = false,
    this.cancelEnabled = false,
    this.clearEnabled = false,
    this.goodDescriptionsList = const [],
    this.addGoodDescriptionEnabled = false,
    this.invoicePdfDto,
  });
  @override
  List<Object?> get props => [
        invoice,
        loading,
        failureOrSuccessOption,
        updatedMode,
        saveEnabled,
        cancelEnabled,
        clearEnabled,
        goodDescriptionsList,
        addGoodDescriptionEnabled,
        invoicePdfDto,
      ];



  CustomerInvoiceFormLoaded copyWith({
    List<InvoiceGoodDescriptionDto>? descriptionList,
    CustomerInvoiceEntity? invoice,
    bool? clearEnabled,
    bool? updatedMode,
    bool? saveEnabled,
    bool? cancelEnabled,
    bool? loading,
    Option<Either<Failure, String>>? failureOrSuccessOption,
    bool? addGoodDescriptionEnabled,
    InvoicePdfDto? invoicePdfDto,
  }) {
    return CustomerInvoiceFormLoaded(
      invoicePdfDto: invoicePdfDto ?? this.invoicePdfDto,
      addGoodDescriptionEnabled: addGoodDescriptionEnabled ?? this.addGoodDescriptionEnabled,
      goodDescriptionsList: descriptionList ?? goodDescriptionsList,
      updatedMode: updatedMode ?? this.updatedMode,
      invoice: invoice ?? this.invoice,
      saveEnabled: saveEnabled ?? this.saveEnabled,
      cancelEnabled: cancelEnabled ?? this.cancelEnabled,
      clearEnabled: clearEnabled ?? this.clearEnabled,
      loading: loading ?? this.loading,
      failureOrSuccessOption: failureOrSuccessOption ?? none(),
    );
  }



  double get allWeight {
    double weight = 0;
    for (var element in goodDescriptionsList) {
      weight += element.weight;
    }
    return weight;
  }

  double get allTotalAmount {
    double price = 0;
    for (var element in goodDescriptionsList) {
      price += element.totalPrice;
    }
    return price;
  }
}

class CustomerInvoiceFormError extends CustomerInvoiceFormState {
  final Failure failure;
  final int id;

  const CustomerInvoiceFormError({required this.failure, required this.id});
}
