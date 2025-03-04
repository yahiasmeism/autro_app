part of 'packing_list_form_cubit.dart';

sealed class PackingListFormState extends Equatable {
  const PackingListFormState();

  @override
  List<Object?> get props => [];
}

final class PackingListFormInitial extends PackingListFormState {}

final class PackingListFormLoaded extends PackingListFormState {
  final PackingListEntity? packingList;
  final bool loading;
  final Option<Either<Failure, String>> failureOrSuccessOption;
  final bool updatedMode;
  final bool saveEnabled;
  final bool addGoodDescriptionEnabled;
  final bool cancelEnabled;
  final bool clearEnabled;
  final bool isGenerateAutoPackingListNumber;
  final PackingListPdfDto? packingListPdfDto;
  final List<PackingListDescriptionDto> goodDescriptionsList;
  final bool onePackingTypeForAll;
  const PackingListFormLoaded({
    this.packingList,
    this.loading = false,
    this.failureOrSuccessOption = const None(),
    this.updatedMode = false,
    this.saveEnabled = false,
    this.cancelEnabled = false,
    this.clearEnabled = false,
    this.goodDescriptionsList = const [],
    this.addGoodDescriptionEnabled = false,
    this.isGenerateAutoPackingListNumber = false,
    this.onePackingTypeForAll = false,
    this.packingListPdfDto,
  });
  @override
  List<Object?> get props => [
        packingList,
        loading,
        failureOrSuccessOption,
        updatedMode,
        saveEnabled,
        cancelEnabled,
        clearEnabled,
        goodDescriptionsList,
        addGoodDescriptionEnabled,
        isGenerateAutoPackingListNumber,
        packingListPdfDto,
        onePackingTypeForAll,
      ];

  PackingListFormLoaded copyWith({
    List<PackingListDescriptionDto>? descriptionList,
    PackingListEntity? packingList,
    bool? clearEnabled,
    bool? updatedMode,
    bool? saveEnabled,
    bool? cancelEnabled,
    bool? loading,
    Option<Either<Failure, String>>? failureOrSuccessOption,
    bool? addGoodDescriptionEnabled,
    bool? isGenerateAutoPackingListNumber,
    PackingListPdfDto? packingListPdfDto,
    bool? onePackingTypeForAll,
  }) {
    return PackingListFormLoaded(
      packingListPdfDto: packingListPdfDto ?? this.packingListPdfDto,
      addGoodDescriptionEnabled:
          addGoodDescriptionEnabled ?? this.addGoodDescriptionEnabled,
      goodDescriptionsList: descriptionList ?? goodDescriptionsList,
      updatedMode: updatedMode ?? this.updatedMode,
      packingList: packingList ?? this.packingList,
      saveEnabled: saveEnabled ?? this.saveEnabled,
      cancelEnabled: cancelEnabled ?? this.cancelEnabled,
      clearEnabled: clearEnabled ?? this.clearEnabled,
      loading: loading ?? this.loading,
      failureOrSuccessOption: failureOrSuccessOption ?? none(),
      isGenerateAutoPackingListNumber: isGenerateAutoPackingListNumber ??
          this.isGenerateAutoPackingListNumber,
      onePackingTypeForAll: onePackingTypeForAll ?? this.onePackingTypeForAll,
    );
  }

  double get allWeight {
    double weight = 0;
    for (var element in goodDescriptionsList) {
      weight += element.weight;
    }
    return weight;
  }
}

class PackingListFormError extends PackingListFormState {
  final Failure failure;
  final int id;

  const PackingListFormError({required this.failure, required this.id});

  @override
  List<Object?> get props => [failure, id];
}

class PackingListPdfDto {
  final String packingListNumber;
  final List<PackingListDescriptionDto> descriptions;
  final String details;
  final String customerName;
  final String customerAddress;
  final String taxId;
  // final DateTime packingListDate;

  PackingListPdfDto({
    required this.packingListNumber,
    required this.descriptions,
    required this.details,
    required this.customerName,
    required this.customerAddress,
    required this.taxId,
    // required this.packingListDate
  });

  double get allWeight {
    double weight = 0;
    for (var element in descriptions) {
      weight += element.weight;
    }
    return weight;
  }

  double get totalCount {
    double amount = 0;
    for (var element in descriptions) {
      amount += element.itemsCount;
    }
    return amount;
  }
}
