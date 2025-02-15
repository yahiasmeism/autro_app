part of 'payments_cubit.dart';

sealed class PaymentsState extends Equatable {
  const PaymentsState();

  @override
  List<Object> get props => [];
}

final class PaymentsInitial extends PaymentsState {}

final class PaymentsLoaded extends PaymentsState {
  final List<PaymentEntity> payments;
  final bool loading;
  final int dealId;
  final Option<Failure> failureOption;

  const PaymentsLoaded({
    required this.payments,
    required this.dealId,
    this.loading = false,
    this.failureOption = const None(),
  });

  List<PaymentEntity> get customerPayments => payments.where((p) => p.clientType == ClientType.customer).toList();
  List<PaymentEntity> get supplierPayments => payments.where((p) => p.clientType == ClientType.supplier).toList();

  @override
  List<Object> get props => [payments, loading, dealId, failureOption];

  PaymentsLoaded copyWith({
    List<PaymentEntity>? payments,
    bool? loading,
    int? dealId,
    Option<Failure>? failureOption,
  }) {
    return PaymentsLoaded(
      payments: payments ?? this.payments,
      loading: loading ?? this.loading,
      dealId: dealId ?? this.dealId,
      failureOption: failureOption ?? this.failureOption,
    );
  }
}

class PaymentsError extends PaymentsState {
  final Failure failure;

  const PaymentsError({required this.failure});
}
