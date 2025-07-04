part of 'supplier_details_cubit.dart';

sealed class SupplierDetailsState extends Equatable {
  const SupplierDetailsState();

  @override
  List<Object> get props => [];
}

final class SupplierDetailsInitial extends SupplierDetailsState {}

final class SupplierDetailsLoaded extends SupplierDetailsState {
  final SupplierEntity supplierEntity;
  const SupplierDetailsLoaded({
    required this.supplierEntity,
  });

  @override
  List<Object> get props => [supplierEntity];

  SupplierDetailsLoaded copyWith({
    SupplierEntity? supplierEntity,
  }) {
    return SupplierDetailsLoaded(
      supplierEntity: supplierEntity ?? this.supplierEntity,
    );
  }
}

class SupplierDetailsError extends SupplierDetailsState {
  final Failure failure;
  final int id;

  const SupplierDetailsError({required this.failure, required this.id});

  @override
  List<Object> get props => [failure, id];
}
