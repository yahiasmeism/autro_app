part of 'bl_instruction_bloc.dart';

sealed class BlInstructionFormState extends Equatable {
  const BlInstructionFormState();

  @override
  List<Object?> get props => [];
}

final class BlInstructionInfoInitial extends BlInstructionFormState {}

final class BlInstructionFormLoaded extends BlInstructionFormState {
  final BlInsturctionEntity? blInstruction;
  final Option<File> pickedAttachment;
  final Option<String> attachmentUrl;
  final bool loading;
  final Option<Either<Failure, String>> failureOrSuccessOption;
  final bool updatedMode;
  final bool saveEnabled;
  final bool cancelEnabled;
  final bool clearEnabled;
  const BlInstructionFormLoaded({
    this.pickedAttachment = const None(),
    this.blInstruction,
    this.loading = false,
    this.failureOrSuccessOption = const None(),
    this.updatedMode = false,
    this.saveEnabled = false,
    this.cancelEnabled = false,
    this.clearEnabled = false,
    this.attachmentUrl = const None(),
  });

  @override
  List<Object?> get props => [
        blInstruction,
        loading,
        failureOrSuccessOption,
        updatedMode,
        saveEnabled,
        cancelEnabled,
        clearEnabled,
        pickedAttachment,
        attachmentUrl,
      ];

  bool get blInstructionHasImageAttachment {
    final attachmentUrl = this.attachmentUrl.fold(() => '', (r) => r);
    if (attachmentUrl.isEmpty) return false;
    return attachmentUrl.split('.').last == 'jpg' ||
        attachmentUrl.split('.').last == 'png' ||
        attachmentUrl.split('.').last == 'jpeg';
  }

  bool get blInstructionHasPdfAttachment {
    final attachmentUrl = this.attachmentUrl.fold(() => '', (r) => r);
    if (attachmentUrl.isEmpty) return false;
    return attachmentUrl.split('.').last == 'pdf';
  }

  BlInstructionFormLoaded copyWith({
    BlInsturctionEntity? blInstruction,
    bool? clearEnabled,
    bool? updatedMode,
    bool? saveEnabled,
    bool? cancelEnabled,
    bool? loading,
    Option<File>? pickedAttachment,
    Option<String>? attachmentUrl,
    Option<Either<Failure, String>>? failureOrSuccessOption,
  }) {
    return BlInstructionFormLoaded(
      attachmentUrl: attachmentUrl ?? this.attachmentUrl,
      updatedMode: updatedMode ?? this.updatedMode,
      blInstruction: blInstruction ?? this.blInstruction,
      saveEnabled: saveEnabled ?? this.saveEnabled,
      cancelEnabled: cancelEnabled ?? this.cancelEnabled,
      clearEnabled: clearEnabled ?? this.clearEnabled,
      loading: loading ?? this.loading,
      failureOrSuccessOption: failureOrSuccessOption ?? none(),
      pickedAttachment: pickedAttachment ?? this.pickedAttachment,
    );
  }
}

class BlInstructionFormError extends BlInstructionFormState {
  final Failure failure;
  final int id;

  const BlInstructionFormError({required this.failure, required this.id});

  @override
  List<Object?> get props => [failure, id];
}
