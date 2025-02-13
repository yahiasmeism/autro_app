part of 'bl_instruction_bloc.dart';

sealed class BlInstructionFormEvent extends Equatable {
  const BlInstructionFormEvent();

  @override
  List<Object?> get props => [];
}

class InitialBlInstructionFormEvent extends BlInstructionFormEvent {
  final int? id;
  const InitialBlInstructionFormEvent({this.id});

  @override
  List<Object?> get props => [id];
}

final class SubmitBlInstructionFormEvent extends BlInstructionFormEvent {}

final class UpdateBlInstructionFormEvent extends BlInstructionFormEvent {}

class CreateBlInstructionFormEvent extends BlInstructionFormEvent {}

class BlInstructionFormChangedEvent extends BlInstructionFormEvent {}


class ClearBlInstructionFormEvent extends BlInstructionFormEvent {}

class CancelBlInstructionFormEvent extends BlInstructionFormEvent {}

class PickAttachmentEvent extends BlInstructionFormEvent {
  final File file;
  const PickAttachmentEvent({required this.file});

  @override
  List<Object?> get props => [file];
}

class ClearAttachmentEvent extends BlInstructionFormEvent {}

class BlInstructionFormHandleFailure extends BlInstructionFormEvent{}