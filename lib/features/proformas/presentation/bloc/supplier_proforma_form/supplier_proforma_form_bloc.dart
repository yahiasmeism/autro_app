import 'dart:io';

import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/extensions/num_extension.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../domin/entities/supplier_proforma_entity.dart';
import '../../../domin/use_cases/create_supplier_proforma_use_case.dart';
import '../../../domin/use_cases/get_supplier_proforma_by_id_use_case.dart';
import '../../../domin/use_cases/update_supplier_proforma_use_case.dart';

part 'supplier_proforma_form_event.dart';
part 'supplier_proforma_form_state.dart';

@injectable
class SupplierProformaFormBloc extends Bloc<SupplierProformaFormEvent, SupplierProformaFormState> {
  final CreateSupplierProformaUseCase createSupplierProformaUsecase;
  final UpdateSupplierProformaUseCase updateSupplierProformaUsecase;
  final GetSupplierProformaByIdUseCase getSupplierProformaUsecase;
  SupplierProformaFormBloc(
    this.createSupplierProformaUsecase,
    this.updateSupplierProformaUsecase,
    this.getSupplierProformaUsecase,
  ) : super(SupplierProformaInfoInitial()) {
    on<SupplierProformaFormEvent>(_mapEvents);
  }

  _mapEvents(SupplierProformaFormEvent event, Emitter<SupplierProformaFormState> emit) async {
    if (event is InitialSupplierProformaFormEvent) {
      await _initial(event, emit);
    }
    if (event is SubmitSupplierProformaFormEvent) {
      await _onSubmitSupplierProforma(event, emit);
    }
    if (event is UpdateSupplierProformaFormEvent) {
      await _onUpdateSupplierProforma(event, emit);
    }
    if (event is CreateSupplierProformaFormEvent) {
      await _onCreateSupplierProforma(event, emit);
    }

    if (event is SupplierProformaFormChangedEvent) {
      await _onSupplierProformaFormChanged(event, emit);
    }
    if (event is CancelSupplierProformaFormEvent) {
      await _onCancelSupplierProformaFormEvent(event, emit);
    }
    if (event is ClearSupplierProformaFormEvent) {
      await _onClearSupplierProformaForm(event, emit);
    }
    if (event is PickAttachmentEvent) {
      await _onPickAttachment(event, emit);
    }

    if (event is ClearAttachmentEvent) {
      await _onClearAttachment(event, emit);
    }
  }

  /* 
  
    final int id;
  final String number;
  final int supplierId;
  final int dealId;
  final double totalAmount;
  final String attachmentUrl;
  final DateTime date;
  final String material;
  final SupplierEntity supplier;
   */

  final formKey = GlobalKey<FormState>();
  final dealIdController = TextEditingController();
  final dealNumberController = TextEditingController();
  final supplierNameController = TextEditingController();
  final supplierIdController = TextEditingController();
  final totalAmountController = TextEditingController();
  final typeMaterialNameController = TextEditingController();
  final dateController = TextEditingController();

  _initial(InitialSupplierProformaFormEvent event, Emitter<SupplierProformaFormState> emit) async {
    if (event.supplierProformaId != null) {
      final supplierProformaEither = await getSupplierProformaUsecase.call(event.supplierProformaId!);

      supplierProformaEither.fold(
        (failure) {},
        (supplierProforma) {
          final attachment = supplierProforma.attachmentUrl;
          emit(SupplierProformaFormLoaded(
            supplierProforma: supplierProforma,
            updatedMode: true,
            attachmentUrl: attachment.isNotEmpty ? some(attachment) : none(),
          ));
        },
      );
    } else {
      emit(const SupplierProformaFormLoaded());
    }

    _initializeControllers();
  }

  _initializeControllers() {
    if (state is SupplierProformaFormLoaded) {
      final state = this.state as SupplierProformaFormLoaded;
      formKey.currentState?.reset();
      dealIdController.text = state.supplierProforma?.dealId.toString() ?? '';
      dealNumberController.text = state.supplierProforma?.number ?? '';
      supplierNameController.text = state.supplierProforma?.supplier.name ?? '';
      supplierIdController.text = state.supplierProforma?.supplier.id.toString() ?? '';
      totalAmountController.text = state.supplierProforma?.totalAmount.toString() ?? '';
      typeMaterialNameController.text = state.supplierProforma?.material ?? '';
      dateController.text = state.supplierProforma?.date.formattedDateYYYYMMDD ?? DateTime.now().formattedDateYYYYMMDD;
      setupControllersListeners();
      add(SupplierProformaFormChangedEvent());
    }
  }

  setupControllersListeners() {
    for (var controller in [
      dealIdController,
      dealNumberController,
      supplierNameController,
      supplierIdController,
      totalAmountController,
      typeMaterialNameController,
      dateController,
    ]) {
      controller.addListener(() => add(SupplierProformaFormChangedEvent()));
    }
  }

  _onSupplierProformaFormChanged(SupplierProformaFormChangedEvent event, Emitter<SupplierProformaFormState> emit) {
    final state = this.state as SupplierProformaFormLoaded;
    final formIsNotEmpty = [
      dealIdController.text.isNotEmpty,
      dealNumberController.text.isNotEmpty,
      supplierNameController.text.isNotEmpty,
      supplierIdController.text.isNotEmpty,
      totalAmountController.text.isNotEmpty,
      dateController.text.isNotEmpty,
    ].every((element) => element);

    final isAnyFieldIsNotEmpty = [
      dealIdController.text.isNotEmpty,
      dealNumberController.text.isNotEmpty,
      supplierNameController.text.isNotEmpty,
      supplierIdController.text.isNotEmpty,
      totalAmountController.text.isNotEmpty,
      typeMaterialNameController.text.isNotEmpty,
      dateController.text.isNotEmpty,
      state.pickedAttachment.isSome(),
    ].any((element) => element);

    if (state.updatedMode) {
      final supplierProforma = state.supplierProforma!;
      final urlChanged = state.attachmentUrl.fold(
        () => supplierProforma.attachmentUrl.isNotEmpty,
        (a) => a != supplierProforma.attachmentUrl,
      );
      bool isFormChanged = supplierProforma.dealId != int.tryParse(dealIdController.text) ||
          supplierProforma.number != dealNumberController.text ||
          supplierProforma.supplier.name != supplierNameController.text ||
          supplierProforma.supplier.id != int.tryParse(supplierIdController.text) ||
          supplierProforma.totalAmount != double.tryParse(totalAmountController.text) ||
          supplierProforma.material != typeMaterialNameController.text ||
          supplierProforma.date.formattedDateYYYYMMDD != dateController.text ||
          state.pickedAttachment.isSome() ||
          urlChanged;

      emit(state.copyWith(
        saveEnabled: formIsNotEmpty && isFormChanged,
        cancelEnabled: isFormChanged,
        clearEnabled: formIsNotEmpty,
      ));
    } else {
      emit(state.copyWith(
        saveEnabled: formIsNotEmpty,
        cancelEnabled: false,
        clearEnabled: isAnyFieldIsNotEmpty,
      ));
    }
  }

  _onSubmitSupplierProforma(SubmitSupplierProformaFormEvent event, Emitter<SupplierProformaFormState> emit) {
    final state = this.state as SupplierProformaFormLoaded;
    if (formKey.currentState?.validate() == false) return;
    if (state.updatedMode) {
      add(UpdateSupplierProformaFormEvent());
    } else {
      add(CreateSupplierProformaFormEvent());
    }
  }

  Future _onCreateSupplierProforma(CreateSupplierProformaFormEvent event, Emitter<SupplierProformaFormState> emit) async {
    final state = this.state as SupplierProformaFormLoaded;
    emit(state.copyWith(loading: true));

    final params = CreateSupplierProformaUseCaseParams(
      material: typeMaterialNameController.text,
      supplierId: int.tryParse(supplierIdController.text).toIntOrZero,
      totalAmount: int.tryParse(totalAmountController.text).toDoubleOrZero,
      dealId: int.tryParse(dealIdController.text).toIntOrZero,
      date: DateTime.tryParse(dateController.text).orDefault,
      attachementPath: state.pickedAttachment.fold(() => null, (file) => file.path),
    );

    final either = await createSupplierProformaUsecase.call(params);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit(
        (state.copyWith(
          failureOrSuccessOption: some(left(failure)),
          supplierProforma: state.supplierProforma,
        )),
      ),
      (supplierProforma) {
        emit(
            state.copyWith(supplierProforma: supplierProforma, failureOrSuccessOption: some(right('Supplier Proforma created'))));
      },
    );
  }

  Future _onUpdateSupplierProforma(UpdateSupplierProformaFormEvent event, Emitter<SupplierProformaFormState> emit) async {
    final state = this.state as SupplierProformaFormLoaded;

    final deleteAttachment = state.attachmentUrl.isNone() && state.pickedAttachment.isNone();
    final parms = UpdateSupplierProformaUseCaseParams(
      date: DateTime.tryParse(dateController.text).orDefault,
      material: typeMaterialNameController.text,
      supplierId: int.tryParse(supplierIdController.text).toIntOrZero,
      totalAmount: double.tryParse(totalAmountController.text).toDoubleOrZero,
      id: state.supplierProforma!.id,
      dealId: int.tryParse(dealIdController.text).toIntOrZero,
      attachementPath: state.pickedAttachment.fold(() => null, (file) => file.path),
      deleteAttachment: deleteAttachment,
    );

    emit(state.copyWith(loading: true));
    final either = await updateSupplierProformaUsecase.call(parms);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit((state.copyWith(failureOrSuccessOption: some(left(failure))))),
      (supplierProforma) {
        emit(
            state.copyWith(supplierProforma: supplierProforma, failureOrSuccessOption: some(right('Supplier Proforma updated'))));
        _initializeControllers();
      },
    );
  }

  _onClearSupplierProformaForm(ClearSupplierProformaFormEvent event, Emitter<SupplierProformaFormState> emit) {
    formKey.currentState?.reset();
    dealIdController.clear();
    dealNumberController.clear();
    supplierNameController.clear();
    supplierIdController.clear();
    totalAmountController.clear();
    typeMaterialNameController.clear();
    dateController.clear();

    if (state is SupplierProformaFormLoaded) {
      final state = this.state as SupplierProformaFormLoaded;
      emit(state.copyWith(pickedAttachment: none(), attachmentUrl: none()));
    }
  }

  _onCancelSupplierProformaFormEvent(SupplierProformaFormEvent event, Emitter<SupplierProformaFormState> emit) {
    final state = this.state as SupplierProformaFormLoaded;
    final proforma = state.supplierProforma;
    if (proforma != null) {
      emit(state.copyWith(
        pickedAttachment: none(),
        attachmentUrl: some(proforma.attachmentUrl),
      ));
    }
    _initializeControllers();
  }

  @override
  Future<void> close() {
    dealIdController.dispose();
    dealNumberController.dispose();
    supplierNameController.dispose();
    supplierIdController.dispose();
    totalAmountController.dispose();
    typeMaterialNameController.dispose();
    dateController.dispose();
    return super.close();
  }

  _onPickAttachment(PickAttachmentEvent event, Emitter<SupplierProformaFormState> emit) async {
    final state = this.state as SupplierProformaFormLoaded;
    emit(state.copyWith(pickedAttachment: some(event.file)));
    add(SupplierProformaFormChangedEvent());
  }

  _onClearAttachment(ClearAttachmentEvent event, Emitter<SupplierProformaFormState> emit) {
    final state = this.state as SupplierProformaFormLoaded;
    emit(
      state.copyWith(
        pickedAttachment: none(),
        attachmentUrl: none(),
      ),
    );
    add(SupplierProformaFormChangedEvent());
  }
}
