import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/features/suppliers/domin/entities/supplier_entity.dart';
import 'package:autro_app/features/suppliers/domin/usecases/get_supplier_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'supplier_details_state.dart';

@injectable
class SupplierDetailsCubit extends Cubit<SupplierDetailsState> {
  final GetSupplierUsecase getSupplierUsecase;
  SupplierDetailsCubit(this.getSupplierUsecase) : super(SupplierDetailsInitial());
  Future getSupplier(int id) async {
    final supplierEntity = await getSupplierUsecase.call(id);

    supplierEntity.fold(
      (failure) => emit(SupplierDetailsError(failure: failure, id: id)),
      (supplier) => emit(SupplierDetailsLoaded(supplierEntity: supplier)),
    );
  }

  updateSupplier(SupplierEntity supplierEntity) async {
    final state = this.state as SupplierDetailsLoaded;
    emit(state.copyWith(supplierEntity: supplierEntity));
  }

  handleError() async {
    if (state is SupplierDetailsError) {
      final state = this.state as SupplierDetailsError;
      emit(SupplierDetailsInitial());
      await Future.delayed(const Duration(milliseconds: 300));
      await getSupplier(state.id);
    }
  }
}
