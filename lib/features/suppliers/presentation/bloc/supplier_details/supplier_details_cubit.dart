import 'package:autro_app/features/suppliers/domin/entities/supplier_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'supplier_details_state.dart';

@injectable
class SupplierDetailsCubit extends Cubit<SupplierDetailsState> {
  SupplierDetailsCubit() : super(SupplierDetailsInitial());
  Future init(SupplierEntity supplierEntity) async {
    emit(SupplierDetailsLoaded(supplierEntity: supplierEntity));
  }

  updateSupplier(SupplierEntity supplierEntity) async {
    final state = this.state as SupplierDetailsLoaded;
    emit(state.copyWith(supplierEntity: supplierEntity));
  }
}
