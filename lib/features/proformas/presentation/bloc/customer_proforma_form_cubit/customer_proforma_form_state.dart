part of 'customer_proforma_form_cubit.dart';

sealed class CustomerProformaFormState extends Equatable {
  const CustomerProformaFormState();

  @override
  List<Object?> get props => [];
}

final class CustomerProformaFormInitial extends CustomerProformaFormState {}

final class CustomerProformaFormLoaded extends CustomerProformaFormState {
  final CustomerProformaEntity? proforma;
  final bool loading;
  final Option<Either<Failure, String>> failureOrSuccessOption;
  final bool updatedMode;
  final bool saveEnabled;
  final bool addGoodDescriptionEnabled;
  final bool cancelEnabled;
  final bool clearEnabled;
  final bool isGenerateAutoProformaNumber;
  final List<ProformaGoodDescriptionDto> goodDescriptionsList;
  const CustomerProformaFormLoaded({
    this.proforma,
    this.loading = false,
    this.failureOrSuccessOption = const None(),
    this.updatedMode = false,
    this.saveEnabled = false,
    this.cancelEnabled = false,
    this.clearEnabled = false,
    this.goodDescriptionsList = const [],
    this.addGoodDescriptionEnabled = false,
    this.isGenerateAutoProformaNumber = false,
  });
  @override
  List<Object?> get props => [
        proforma,
        loading,
        failureOrSuccessOption,
        updatedMode,
        saveEnabled,
        cancelEnabled,
        clearEnabled,
        goodDescriptionsList,
        addGoodDescriptionEnabled,
        isGenerateAutoProformaNumber,
      ];

  CustomerProformaFormLoaded copyWith({
    List<ProformaGoodDescriptionDto>? descriptionList,
    CustomerProformaEntity? proforma,
    bool? clearEnabled,
    bool? updatedMode,
    bool? saveEnabled,
    bool? cancelEnabled,
    bool? loading,
    Option<Either<Failure, String>>? failureOrSuccessOption,
    bool? addGoodDescriptionEnabled,
    bool? isGenerateAutoProformaNumber,
  }) {
    return CustomerProformaFormLoaded(
      addGoodDescriptionEnabled: addGoodDescriptionEnabled ?? this.addGoodDescriptionEnabled,
      goodDescriptionsList: descriptionList ?? goodDescriptionsList,
      updatedMode: updatedMode ?? this.updatedMode,
      proforma: proforma ?? this.proforma,
      saveEnabled: saveEnabled ?? this.saveEnabled,
      cancelEnabled: cancelEnabled ?? this.cancelEnabled,
      clearEnabled: clearEnabled ?? this.clearEnabled,
      loading: loading ?? this.loading,
      failureOrSuccessOption: failureOrSuccessOption ?? none(),
      isGenerateAutoProformaNumber: isGenerateAutoProformaNumber ?? this.isGenerateAutoProformaNumber,
    );
  }

  int get allContainerCount {
    int count = 0;
    for (var element in goodDescriptionsList) {
      count += element.containersCount;
    }
    return count;
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

class CustomerProformaFormError extends CustomerProformaFormState {
  final Failure failure;
  final int id;

  const CustomerProformaFormError({required this.failure, required this.id});

  @override
  List<Object?> get props => [failure, id];
}
