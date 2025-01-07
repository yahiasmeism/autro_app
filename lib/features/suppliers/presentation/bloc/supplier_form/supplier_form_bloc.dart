import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/features/suppliers/domin/entities/supplier_entity.dart';
import 'package:autro_app/features/suppliers/presentation/bloc/suppliers_list/suppliers_list_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../suppliers/domin/usecases/create_supplier_usecase.dart';
import '../../../../suppliers/domin/usecases/update_supplier_usecase.dart';

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
    if (event is CreateSupplierFormEvent) {
      await _onCreateSupplier(event, emit);
    }
    if (event is UpdateSupplierFormEvent) {
      await _onUpdateSupplier(event, emit);
    }
  }

  _initial(InitialSupplierFormEvent event, Emitter<SupplierFormState> emit) {
    emit(SupplierFormLoaded(supplier: event.supplier, formType: event.formType));
  }

  Future _onCreateSupplier(CreateSupplierFormEvent event, Emitter<SupplierFormState> emit) async {
    final state = this.state as SupplierFormLoaded;
    emit(state.copyWith(loading: true));

    final either = await createSupplierUsecase.call(event.toParams());
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
    final supplierEntity = state.supplier?.copyWith();
    if (supplierEntity == event.supplier) {
      emit(state.copyWith(failureOrSuccessOption: some(right(''))));
      return;
    }
    emit(state.copyWith(loading: true));
    final either = await updateSupplierUsecase.call(UpdateSupplierUsecaseParams(event.supplier));
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit((state.copyWith(failureOrSuccessOption: some(left(failure))))),
      (supplier) {
        suppliersListBloc.add(AddedUpdatedSupplierEvent());
        emit(state.copyWith(supplier: supplier, failureOrSuccessOption: some(right('Supplier updated'))));
      },
    );
  }
}
