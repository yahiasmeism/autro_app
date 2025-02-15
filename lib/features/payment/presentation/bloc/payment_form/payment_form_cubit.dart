import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/features/payment/domin/entities/payment_entity.dart';
import 'package:autro_app/features/payment/domin/usecases/update_payment_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'payment_form_state.dart';

@injectable
class PaymentFormCubit extends Cubit<PaymentFormState> {
  final UpdatePaymentUseCase updatePaymentUseCase;
  PaymentFormCubit(this.updatePaymentUseCase) : super(const PaymentFormState());

  final totalAmountController = TextEditingController();
  final prePaymentController = TextEditingController();
  final paymentDateController = TextEditingController(text: DateTime.now().formattedDateYYYYMMDD);
  final remainingAmountController = TextEditingController();

  init(PaymentEntity payment, BuildContext context) {
    emit(state.copyWith(
      paymentEntity: payment,
      context: context,
    ));
    _initializeControllers();
  }

  _initializeControllers() {
    final payment = state.paymentEntity!;
    totalAmountController.text = payment.amount.toStringAsFixed(2);
    prePaymentController.text = payment.prePayment.toStringAsFixed(2);
    paymentDateController.text = payment.date.formattedDateYYYYMMDD;
    final remainingValue =
        ((double.tryParse(totalAmountController.text) ?? 0) - (double.tryParse(prePaymentController.text) ?? 0));
    remainingAmountController.text = (remainingValue > 0 ? remainingValue : 0).toString();

    _setupControllerListener();
  }

  bool get formIsChanged {
    final payment = state.paymentEntity!;
    return totalAmountController.text != payment.amount.toStringAsFixed(2) ||
        prePaymentController.text != payment.prePayment.toStringAsFixed(2) ||
        paymentDateController.text != payment.date.formattedDateYYYYMMDD;
  }

  bool get formIsValid {
    return double.tryParse(totalAmountController.text) != null &&
        double.tryParse(prePaymentController.text) != null &&
        DateTime.tryParse(paymentDateController.text) != null;
  }

  _setupControllerListener() {
    totalAmountController.addListener(_onChangeControllers);
    prePaymentController.addListener(_onChangeControllers);
    paymentDateController.addListener(_onChangeControllers);
  }

  _onChangeControllers() {
    final remainingValue =
        ((double.tryParse(totalAmountController.text) ?? 0) - (double.tryParse(prePaymentController.text) ?? 0));
    remainingAmountController.text = (remainingValue > 0 ? remainingValue : 0).toString();

    emit(state.copyWith(canSave: formIsChanged && formIsValid));
  }

  savePayment() async {
    if (!formIsChanged) {
      toggleUpdateMode();
      return;
    }
    emit(state.copyWith(saving: true));
    final params = UpdatePaymentUseCaseParams(
      state.paymentEntity!.id,
      double.tryParse(totalAmountController.text) ?? 0,
      double.tryParse(prePaymentController.text) ?? 0,
      DateTime.tryParse(paymentDateController.text) ?? DateTime.now(),
    );

    final result = await updatePaymentUseCase.call(params);
    emit(state.copyWith(saving: false));
    result.fold(
      (failure) => emit(state.copyWith(failureOrSuccessOption: some(left(failure)))),
      (payment) {
        emit(state.copyWith(paymentEntity: payment, failureOrSuccessOption: some(right('Payment updated'))));
      },
    );
    _initializeControllers();

    toggleUpdateMode();
  }

  toggleUpdateMode() {
    emit(state.copyWith(updateMode: !state.updateMode));
  }
}
