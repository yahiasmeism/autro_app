part of 'payment_form_cubit.dart';

class PaymentFormState extends Equatable {
  final PaymentEntity? paymentEntity;
  final bool saving;
  final bool isManual;
  final bool updateMode;
  final bool canSave;
  final Option<Either<Failure, String>> failureOrSuccessOption;
  final BuildContext? context;
  const PaymentFormState({
    this.paymentEntity,
    this.updateMode = false,
    this.canSave = false,
    this.saving = false,
    this.isManual = false,
    this.context,
    this.failureOrSuccessOption = const None(),
  });

  PaymentFormState copyWith({
    PaymentEntity? paymentEntity,
    bool? saving,
    bool? isManual,
    bool? updateMode,
    BuildContext? context,
    Option<Either<Failure, String>>? failureOrSuccessOption,
    bool? canSave,
  }) {
    return PaymentFormState(
      paymentEntity: paymentEntity ?? this.paymentEntity,
      saving: saving ?? this.saving,
      isManual: isManual ?? this.isManual,
      updateMode: updateMode ?? this.updateMode,
      context: context ?? this.context,
      failureOrSuccessOption: failureOrSuccessOption ?? none(),
      canSave: canSave ?? this.canSave,
    );
  }

  @override
  List<Object?> get props => [paymentEntity, saving, isManual, updateMode, context, failureOrSuccessOption, canSave];
}
