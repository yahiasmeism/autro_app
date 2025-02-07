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
  final List<PackingListDescriptionDto> goodDescriptionsList;
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
  }) {
    return PackingListFormLoaded(
      addGoodDescriptionEnabled: addGoodDescriptionEnabled ?? this.addGoodDescriptionEnabled,
      goodDescriptionsList: descriptionList ?? goodDescriptionsList,
      updatedMode: updatedMode ?? this.updatedMode,
      packingList: packingList ?? this.packingList,
      saveEnabled: saveEnabled ?? this.saveEnabled,
      cancelEnabled: cancelEnabled ?? this.cancelEnabled,
      clearEnabled: clearEnabled ?? this.clearEnabled,
      loading: loading ?? this.loading,
      failureOrSuccessOption: failureOrSuccessOption ?? none(),
      isGenerateAutoPackingListNumber: isGenerateAutoPackingListNumber ?? this.isGenerateAutoPackingListNumber,
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
