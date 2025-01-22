part of 'proforma_form_cubit.dart';

sealed class ProformaFormState extends Equatable {
  const ProformaFormState();

  @override
  List<Object?> get props => [];
}

final class ProformaFormInitial extends ProformaFormState {}

final class ProformaFormLoaded extends ProformaFormState {
  final ProformaEntity? proforma;
  final bool loading;
  final Option<Either<Failure, String>> failureOrSuccessOption;
  final bool updatedMode;
  final bool saveEnabled;
  final bool addGoodDescriptionEnabled;
  final bool cancelEnabled;
  final bool clearEnabled;
  final List<ProformaGoodDescriptionDto> goodDescriptionsList;
  const ProformaFormLoaded({
    this.proforma,
    this.loading = false,
    this.failureOrSuccessOption = const None(),
    this.updatedMode = false,
    this.saveEnabled = false,
    this.cancelEnabled = false,
    this.clearEnabled = false,
    this.goodDescriptionsList = const [],
    this.addGoodDescriptionEnabled = false,
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
      ];

  ProformaFormLoaded copyWith({
    List<ProformaGoodDescriptionDto>? descriptionList,
    ProformaEntity? proforma,
    bool? clearEnabled,
    bool? updatedMode,
    bool? saveEnabled,
    bool? cancelEnabled,
    bool? loading,
    Option<Either<Failure, String>>? failureOrSuccessOption,
    bool? addGoodDescriptionEnabled,
  }) {
    return ProformaFormLoaded(
      addGoodDescriptionEnabled: addGoodDescriptionEnabled ?? this.addGoodDescriptionEnabled,
      goodDescriptionsList: descriptionList ?? goodDescriptionsList,
      updatedMode: updatedMode ?? this.updatedMode,
      proforma: proforma ?? this.proforma,
      saveEnabled: saveEnabled ?? this.saveEnabled,
      cancelEnabled: cancelEnabled ?? this.cancelEnabled,
      clearEnabled: clearEnabled ?? this.clearEnabled,
      loading: loading ?? this.loading,
      failureOrSuccessOption: failureOrSuccessOption ?? none(),
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
