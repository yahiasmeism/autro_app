import 'package:autro_app/features/payment/domin/usecases/get_payments_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/constants/enums.dart';
import '../../../../../core/errors/failures.dart';
import '../../../domin/entities/payment_entity.dart';

part 'payments_state.dart';

@injectable
class PaymentsCubit extends Cubit<PaymentsState> {
  final GetPaymentsUseCase getPaymentsUseCase;
  PaymentsCubit(this.getPaymentsUseCase) : super(PaymentsInitial());

  getPayments(int dealId) async {
    emit(PaymentsInitial());
    final result = await getPaymentsUseCase(GetPaymentsUseCaseParams(dealId: dealId));
    result.fold((l) => emit(PaymentsError(failure: l)), (r) => emit(PaymentsLoaded(payments: r, dealId: dealId)));
  }


  refresh() async {
    final state = this.state as PaymentsLoaded;
    emit(state.copyWith(loading: true));

    final result = await getPaymentsUseCase(GetPaymentsUseCaseParams(dealId: state.dealId));

    emit(state.copyWith(loading: false));

    result.fold(
      (l) => emit(state.copyWith(failureOption: some(l))),
      (r) => emit(state.copyWith(payments: r)),
    );
  }

  updateLoading(bool loading) {
    if (state is PaymentsLoaded) {
      final state = this.state as PaymentsLoaded;
      emit(state.copyWith(loading: loading));
    }
  }
}
