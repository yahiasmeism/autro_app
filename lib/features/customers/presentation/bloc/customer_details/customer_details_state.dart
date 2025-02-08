part of 'customer_details_cubit.dart';

sealed class CustomerDetailsState extends Equatable {
  const CustomerDetailsState();

  @override
  List<Object> get props => [];
}

final class CustomerDetailsInitial extends CustomerDetailsState {}

final class CustomerDetailsLoaded extends CustomerDetailsState {
  final CustomerEntity customerEntity;
  const CustomerDetailsLoaded({
    required this.customerEntity,
  });

  @override
  List<Object> get props => [customerEntity];

  CustomerDetailsLoaded copyWith({
    CustomerEntity? customerEntity,
  }) {
    return CustomerDetailsLoaded(
      customerEntity: customerEntity ?? this.customerEntity,
    );
  }
}

class CustomerDetailsError extends CustomerDetailsState {
  final Failure failure;
  final int id;
  const CustomerDetailsError({required this.failure,required this.id});

  @override
  List<Object> get props => [failure];
}
