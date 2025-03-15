import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/features/packing-lists/domin/dtos/packing_list_controllers_dto.dart';
import 'package:autro_app/features/packing-lists/domin/dtos/packing_list_description_dto.dart';
import 'package:autro_app/features/packing-lists/domin/entities/packing_list_entity.dart';
import 'package:autro_app/features/packing-lists/domin/use_cases/create_packing_list_use_case.dart';
import 'package:autro_app/features/packing-lists/domin/use_cases/get_packing_list_by_id_use_case.dart';
import 'package:autro_app/features/packing-lists/domin/use_cases/update_packing_list_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'packing_list_form_state.dart';

@injectable
class PackingListFormCubit extends Cubit<PackingListFormState> {
  final CreatePackingListUseCase createPackingListUsecase;
  final UpdatePackingListUseCase updatePackingListUsecase;
  final GetPackingListByIdUseCase getPackingListByIdUseCase;
  PackingListFormCubit(
    this.createPackingListUsecase,
    this.updatePackingListUsecase,
    this.getPackingListByIdUseCase,
  ) : super(PackingListFormInitial());

  final customerNameController = TextEditingController();
  final customerAddressController = TextEditingController();
  final taxIdController = TextEditingController();
  // packing list
  final formKey = GlobalKey<FormState>();
  final numberController = TextEditingController();
  final dealIdController = TextEditingController();
  final detailsController = TextEditingController();

  Future init({required int? packingListId}) async {
    emit(PackingListFormInitial());
    if (packingListId != null) {
      final either = await getPackingListByIdUseCase.call(packingListId);

      either.fold(
        (failure) {
          emit(PackingListFormError(failure: failure, id: packingListId));
        },
        (packingList) {
          final initialgoodsDescription = packingList.descriptions.map((e) => PackingListControllersDto.fromEntity(e)).toList();
          emit(PackingListFormLoaded(
            packingList: packingList,
            goodDescriptionsControllersDTOsList: initialgoodsDescription,
            updatedMode: true,
          ));
        },
      );
    } else {
      emit(const PackingListFormLoaded());
    }

    await _initializeControllers();
  }

  _initializeControllers() {
    if (state is PackingListFormLoaded) {
      final state = this.state as PackingListFormLoaded;
      formKey.currentState?.reset();

      numberController.text = state.packingList?.number ?? '';
      dealIdController.text = state.packingList?.dealId.toString() ?? '';
      detailsController.text = state.packingList?.details ?? '';

      customerNameController.text = state.packingList?.customer.name ?? '';
      customerAddressController.text = state.packingList?.customer.formattedAddress ?? '';
      taxIdController.text = state.packingList?.taxId ?? '';

      _setupControllersListeners();
      _onPackingListFormChanged();
    }
  }

  _setupControllersListeners() {
    // PackingList
    for (var controller in [
      numberController,
      dealIdController,
      detailsController,
    ]) {
      controller.addListener(() => _onPackingListFormChanged());
    }
    // // Goods Descriptions
    // for (var controller in [
    //   containerNumberController,
    //   weightController,
    //   emptyContainerWeightController,
    //   typeController,
    //   itemsCountController,
    //   dateController,
    //   percentoController,
    // ]) {
    //   controller.addListener(() => _onGoodDescriptionInputChanged());
    // }
  }

  // _onGoodDescriptionInputChanged() {
  //   final addGoodDescriptionIsActive = [
  //     containerNumberController,
  //     weightController,
  //     emptyContainerWeightController,
  //     typeController,
  //     itemsCountController,
  //     dateController,
  //     percentoController,
  //   ].every((controller) => controller.text.isNotEmpty);

  //   final state = this.state as PackingListFormLoaded;
  //   emit(state.copyWith(addGoodDescriptionEnabled: addGoodDescriptionIsActive));

  //   // Calculate vgm
  //   final weight = double.tryParse(weightController.text) ?? 0.0;
  //   final emptyWeight = double.tryParse(emptyContainerWeightController.text) ?? 0.0;
  //   vgmController.text = (weight + emptyWeight).toString();
  // }

  _onPackingListFormChanged() {
    final state = this.state as PackingListFormLoaded;
    final formIsNotEmpty = [
      numberController,
      dealIdController,
    ].every((controller) => controller.text.isNotEmpty && state.goodDescriptionsDTOsList.isNotEmpty);
    // state.goodDescriptionsList.any((element) => element.containerNumber.text.isNotEmpty);

    if (state.updatedMode) {
      final initialgoodsDescription =
          state.packingList!.descriptions.map((e) => PackingListDescriptionDto.fromEntity(e)).toList();

      bool isGoodsDescriptionChanged = !listEquals(
        initialgoodsDescription,
        state.goodDescriptionsDTOsList,
      );
      final packingList = state.packingList!;

      bool isFormChanged = numberController.text != packingList.number ||
          dealIdController.text != packingList.dealId.toString() ||
          detailsController.text != packingList.details ||
          isGoodsDescriptionChanged;

      emit(state.copyWith(
        saveEnabled: formIsNotEmpty && isFormChanged,
        cancelEnabled: isFormChanged,
        clearEnabled: formIsNotEmpty,
        packingListPdfDto: formIsNotEmpty ? mapFormDataToPackingListPdfDto() : null,
      ));
    } else {
      emit(state.copyWith(
        saveEnabled: formIsNotEmpty,
        cancelEnabled: false,
        clearEnabled: formIsNotEmpty,
      ));
    }
  }

  bool listEquals(List a, List b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  // _clearGoodDescriptionForm() {
  //   for (var controller in [
  //     containerNumberController,
  //     weightController,
  //     emptyContainerWeightController,
  //     typeController,
  //     itemsCountController,
  //     dateController,
  //     percentoController,
  //   ]) {
  //     controller.clear();
  //   }
  // }

  addGoodDescription(PackingListControllersDto dto) {
    final state = this.state as PackingListFormLoaded;
    emit(state.copyWith(descriptionList: [...state.goodDescriptionsControllersDTOsList, dto]));
    // _clearGoodDescriptionForm();
    _onPackingListFormChanged();
  }

  removeGoodDescription(PackingListControllersDto dto) {
    final state = this.state as PackingListFormLoaded;
    final updatedList = List.of(state.goodDescriptionsControllersDTOsList)..remove(dto);
    emit(state.copyWith(descriptionList: updatedList));
    _onPackingListFormChanged();
  }

  Future createPackingList() async {
    final state = this.state as PackingListFormLoaded;

    final isFormValid = formKey.currentState!.validate();

    if (!isFormValid) {
      return;
    }
    emit(state.copyWith(loading: true));
    if (!descriptionsValidations()) {
      emit(state.copyWith(loading: false));
      return;
    }

    final params = CreatePackingListUseCaseParams(
      dealId: int.parse(dealIdController.text),
      details: detailsController.text,
      number: numberController.text,
      descriptions: state.goodDescriptionsControllersDTOsList.map((e) => e.toDescriptionDTO()).toList(),
      taxId: taxIdController.text,
    );

    final either = await createPackingListUsecase.call(params);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit(
        (state.copyWith(
          failureOrSuccessOption: some(left(failure)),
          packingList: state.packingList,
        )),
      ),
      (packingList) {
        emit(state.copyWith(packingList: packingList, failureOrSuccessOption: some(right('Packing list created'))));
      },
    );
  }

  Future updatePackingList() async {
    final state = this.state as PackingListFormLoaded;

    emit(state.copyWith(loading: true));
    if (!descriptionsValidations()) {
      emit(state.copyWith(loading: false));
      return;
    }
    final params = UpdatePackingListUseCaseParams(
      id: state.packingList!.id,
      taxId: taxIdController.text,
      dealId: int.parse(dealIdController.text),
      details: detailsController.text,
      number: numberController.text,
      descriptions: state.goodDescriptionsControllersDTOsList.map((e) => e.toDescriptionDTO()).toList(),
    );

    final either = await updatePackingListUsecase.call(params);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit((state.copyWith(failureOrSuccessOption: some(left(failure))))),
      (packingList) {
        emit(state.copyWith(packingList: packingList, failureOrSuccessOption: some(right('PackingList updated'))));
        _initializeControllers();
      },
    );
    _onPackingListFormChanged();
  }

  updateGoodDescription(PackingListControllersDto dto) {
    final state = this.state as PackingListFormLoaded;
    final index = state.goodDescriptionsControllersDTOsList.indexWhere((element) => element.uniqueKey == dto.uniqueKey);

    if (index != -1) {
      final updatedList = List.of(state.goodDescriptionsControllersDTOsList);
      updatedList[index] = dto;
      emit(state.copyWith(descriptionList: updatedList));
      _onPackingListFormChanged();
    }
  }

  cancelChanges() {
    final state = this.state as PackingListFormLoaded;
    init(packingListId: state.packingList?.id);
  }

  toggleGenerateAutoPackingListNumber() {
    final state = this.state as PackingListFormLoaded;
    emit(state.copyWith(isGenerateAutoPackingListNumber: !state.isGenerateAutoPackingListNumber));
  }

  addGoodsDescription(List<PackingListDescriptionDto> descriptions) {
    final state = this.state as PackingListFormLoaded;
    emit(state.copyWith(descriptionList: descriptions.map((e) => e.toControllersDTO()).toList()));
  }

  bool descriptionsValidations() {
    final state = this.state as PackingListFormLoaded;
    final isAnyContainerNumberEmpty = state.goodDescriptionsDTOsList.any((element) => element.containerNumber.isEmpty);
    if (isAnyContainerNumberEmpty) {
      emit(state.copyWith(failureOrSuccessOption: some(left(const GeneralFailure(message: 'Container number cannot be empty')))));
      return false;
    }

    final isAnyWeightEmpty = state.goodDescriptionsDTOsList.any((element) => element.weight == 0.0);

    if (isAnyWeightEmpty) {
      emit(state.copyWith(failureOrSuccessOption: some(left(const GeneralFailure(message: 'Weight cannot be empty')))));
      return false;
    }

    final isAnyItemsCountEmpty = state.goodDescriptionsDTOsList.any((element) => element.itemsCount == 0);

    if (isAnyItemsCountEmpty) {
      emit(state.copyWith(failureOrSuccessOption: some(left(const GeneralFailure(message: 'Items count cannot be empty')))));
      return false;
    }

    final isAnyTypeEmpty = state.goodDescriptionsDTOsList.any((element) => element.type == null);

    if (isAnyTypeEmpty) {
      emit(state.copyWith(failureOrSuccessOption: some(left(const GeneralFailure(message: 'Package type cannot be empty')))));
      return false;
    }

    final isContainerEmptyWeightEmpty = state.goodDescriptionsDTOsList.any((element) => element.emptyContainerWeight == 0.0);

    if (isContainerEmptyWeightEmpty) {
      emit(state.copyWith(
          failureOrSuccessOption: some(left(const GeneralFailure(message: 'Empty container weight cannot be empty')))));
      return false;
    }

    return true;
  }

  handleFailure() async {
    if (state is PackingListFormError) {
      final state = this.state as PackingListFormError;
      emit(PackingListFormInitial());
      await Future.delayed(const Duration(milliseconds: 300));
      init(packingListId: state.id);
    }
  }

  PackingListPdfDto? mapFormDataToPackingListPdfDto() {
    final state = this.state as PackingListFormLoaded;

    return PackingListPdfDto(
      customerName: customerNameController.text,
      customerAddress: customerAddressController.text,
      taxId: taxIdController.text,
      details: detailsController.text,
      descriptions: state.goodDescriptionsControllersDTOsList.map((e) => e.toDescriptionDTO()).toList(),
      packingListNumber: numberController.text,
    );
  }

  toggleOnePackingTypeForAllCheckBox() {
    final state = this.state as PackingListFormLoaded;
    emit(state.copyWith(onePackingTypeForAll: !state.onePackingTypeForAll));
  }
}
