import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/extensions/primary_contact_type_extension.dart';
import 'package:autro_app/features/suppliers/domin/entities/supplier_entity.dart';
import 'package:autro_app/features/suppliers/presentation/bloc/suppliers_list/suppliers_list_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../domin/usecases/create_supplier_usecase.dart';
import '../../../domin/usecases/update_supplier_usecase.dart';

part 'supplier_form_event.dart';
part 'supplier_form_state.dart';

@injectable
class SupplierFormBloc extends Bloc<SupplierFormEvent, SupplierFormState> {
  final CreateSupplierUsecase createSupplierUsecase;
  final UpdateSupplierUsecase updateSupplierUsecase;
  final SuppliersListBloc suppliersListBloc;
  SupplierFormBloc(
    this.createSupplierUsecase,
    this.updateSupplierUsecase,
    this.suppliersListBloc,
  ) : super(SupplierInfoInitial()) {
    on<SupplierFormEvent>(_mapEvents);
  }

  _mapEvents(SupplierFormEvent event, Emitter<SupplierFormState> emit) async {
    if (event is InitialSupplierFormEvent) {
      await _initial(event, emit);
    }
    if (event is SubmitSupplierFormEvent) {
      await _onSubmitSupplier(event, emit);
    }
    if (event is UpdateSupplierFormEvent) {
      await _onUpdateSupplier(event, emit);
    }
    if (event is CreateSupplierFormEvent) {
      await _onCreateSupplier(event, emit);
    }
    if (event is SupplierFormChangedEvent) {
      await _onSupplierFormChanged(event, emit);
    }
    if (event is CancelSupplierFormEvent) {
      await _onCancelSupplierFormEvent(event, emit);
    }
    if (event is ClearSupplierFormEvent) {
      await _onClearSupplierForm(event, emit);
    }
  }

  final nameController = TextEditingController();
  final primaryContactController = TextEditingController();
  final country = TextEditingController();
  final city = TextEditingController();
  final website = TextEditingController();
  final businessDetails = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final altPhone = TextEditingController();
  final notes = TextEditingController();
  final formKey = GlobalKey<FormState>();

  _initial(InitialSupplierFormEvent event, Emitter<SupplierFormState> emit) {
    emit(SupplierFormLoaded(supplier: event.supplier, updatedMode: event.supplier != null));
    _initializeControllers();
  }

  _initializeControllers() {
    final state = this.state as SupplierFormLoaded;
    nameController.text = state.supplier?.name ?? '';
    country.text = state.supplier?.country ?? '';
    city.text = state.supplier?.city ?? '';
    website.text = state.supplier?.website ?? '';
    businessDetails.text = state.supplier?.businessDetails ?? '';
    email.text = state.supplier?.email ?? '';
    phone.text = state.supplier?.phone ?? '';
    altPhone.text = state.supplier?.altPhone ?? '';
    primaryContactController.text = state.supplier?.primaryContactType.str ?? '';
    notes.text = state.supplier?.notes ?? '';
    setupControllersListeners();
    add(SupplierFormChangedEvent());
  }

  setupControllersListeners() {
    nameController.addListener(() => add(SupplierFormChangedEvent()));
    country.addListener(() => add(SupplierFormChangedEvent()));
    city.addListener(() => add(SupplierFormChangedEvent()));
    website.addListener(() => add(SupplierFormChangedEvent()));
    businessDetails.addListener(() => add(SupplierFormChangedEvent()));
    email.addListener(() => add(SupplierFormChangedEvent()));
    phone.addListener(() => add(SupplierFormChangedEvent()));
    altPhone.addListener(() => add(SupplierFormChangedEvent()));
    primaryContactController.addListener(() => add(SupplierFormChangedEvent()));
    notes.addListener(() => add(SupplierFormChangedEvent()));
  }

  _onSupplierFormChanged(SupplierFormChangedEvent event, Emitter<SupplierFormState> emit) {
    final state = this.state as SupplierFormLoaded;
    final formIsNotEmpty = nameController.text.isNotEmpty ||
        country.text.isNotEmpty ||
        city.text.isNotEmpty ||
        website.text.isNotEmpty ||
        businessDetails.text.isNotEmpty ||
        email.text.isNotEmpty ||
        phone.text.isNotEmpty ||
        altPhone.text.isNotEmpty ||
        primaryContactController.text.isNotEmpty ||
        notes.text.isNotEmpty;

    if (state.updatedMode) {
      final supplier = state.supplier!;
      bool isFormChanged = supplier.name != nameController.text ||
          supplier.country != country.text ||
          supplier.city != city.text ||
          supplier.website != website.text ||
          supplier.businessDetails != businessDetails.text ||
          supplier.email != email.text ||
          supplier.phone != phone.text ||
          supplier.altPhone != altPhone.text ||
          supplier.primaryContactType.str.toLowerCase() != primaryContactController.text.toLowerCase() ||
          supplier.notes != notes.text;
      emit(state.copyWith(
          saveEnabled: formIsNotEmpty && isFormChanged, cancelEnabled: isFormChanged, clearEnabled: formIsNotEmpty));
    } else {
      emit(state.copyWith(saveEnabled: formIsNotEmpty, cancelEnabled: false, clearEnabled: formIsNotEmpty));
    }
  }

  _onSubmitSupplier(SubmitSupplierFormEvent event, Emitter<SupplierFormState> emit) {
    final state = this.state as SupplierFormLoaded;
    if (state.updatedMode) {
      add(UpdateSupplierFormEvent());
    } else {
      add(CreateSupplierFormEvent());
    }
  }

  Future _onCreateSupplier(CreateSupplierFormEvent event, Emitter<SupplierFormState> emit) async {
    final state = this.state as SupplierFormLoaded;
    emit(state.copyWith(loading: true));

    final params = CreateSupplierUsecaseParams(
      name: nameController.text,
      country: country.text,
      city: city.text,
      website: website.text,
      businessDetails: businessDetails.text,
      email: email.text,
      phone: phone.text,
      altPhone: altPhone.text,
      primaryContactType: PrimaryContactTypeX.fromString(primaryContactController.text),
      notes: notes.text,
    );

    final either = await createSupplierUsecase.call(params);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit(
        (state.copyWith(
          failureOrSuccessOption: some(left(failure)),
          supplier: state.supplier,
        )),
      ),
      (supplier) {
        suppliersListBloc.add(AddedUpdatedSupplierEvent());
        emit(state.copyWith(supplier: supplier, failureOrSuccessOption: some(right('Supplier created'))));
      },
    );
  }

  Future _onUpdateSupplier(UpdateSupplierFormEvent event, Emitter<SupplierFormState> emit) async {
    final state = this.state as SupplierFormLoaded;

    final updatedSupplier = state.supplier!.copyWith(
      name: nameController.text,
      country: country.text,
      city: city.text,
      website: website.text,
      businessDetails: businessDetails.text,
      email: email.text,
      phone: phone.text,
      altPhone: altPhone.text,
      primaryContactType: PrimaryContactTypeX.fromString(primaryContactController.text),
      notes: notes.text,
    );

    emit(state.copyWith(loading: true));
    final either = await updateSupplierUsecase.call(UpdateSupplierUsecaseParams(updatedSupplier));
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit((state.copyWith(failureOrSuccessOption: some(left(failure))))),
      (supplier) {
        suppliersListBloc.add(AddedUpdatedSupplierEvent());
        emit(state.copyWith(supplier: supplier, failureOrSuccessOption: some(right('Supplier updated'))));
        _initializeControllers();
      },
    );
  }

  _onClearSupplierForm(ClearSupplierFormEvent event, Emitter<SupplierFormState> emit) {
    nameController.text = '';
    country.text = '';
    city.text = '';
    website.text = '';
    businessDetails.text = '';
    email.text = '';
    phone.text = '';
    altPhone.text = '';
    primaryContactController.text = '';
    notes.text = '';
  }

  _onCancelSupplierFormEvent(SupplierFormEvent event, Emitter<SupplierFormState> emit) => _initializeControllers();

  @override
  Future<void> close() {
    nameController.dispose();
    country.dispose();
    city.dispose();
    website.dispose();
    businessDetails.dispose();
    email.dispose();
    phone.dispose();
    altPhone.dispose();
    primaryContactController.dispose();
    notes.dispose();
    return super.close();
  }
}
