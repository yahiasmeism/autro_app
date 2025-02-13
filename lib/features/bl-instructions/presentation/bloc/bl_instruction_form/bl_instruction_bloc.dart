import 'dart:io';

import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/extensions/num_extension.dart';
import 'package:autro_app/features/bl-instructions/domin/entities/bl_insturction_entity.dart';
import 'package:autro_app/features/bl-instructions/domin/usecases/get_bl_instruction_by_id_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../domin/usecases/create_bl_instruction_use_case.dart';
import '../../../domin/usecases/update_bl_instruction_use_case.dart';

part 'bl_instruction_form_event.dart';
part 'bl_instruction_form_state.dart';

@injectable
class BlInstructionFormBloc extends Bloc<BlInstructionFormEvent, BlInstructionFormState> {
  final CreateBlInsturctionUseCase createBlInstructionUsecase;
  final UpdateBlInsturctionsUseCase updateBlInstructionUsecase;
  final GetBlInsturctionByIdUseCase getBlInstructionByIdUseCase;
  BlInstructionFormBloc(
    this.createBlInstructionUsecase,
    this.updateBlInstructionUsecase,
    this.getBlInstructionByIdUseCase,
  ) : super(BlInstructionInfoInitial()) {
    on<BlInstructionFormEvent>(_mapEvents);
  }

  _mapEvents(BlInstructionFormEvent event, Emitter<BlInstructionFormState> emit) async {
    if (event is InitialBlInstructionFormEvent) {
      await _initial(event, emit);
    }
    if (event is SubmitBlInstructionFormEvent) {
      await _onSubmitBlInstruction(event, emit);
    }
    if (event is UpdateBlInstructionFormEvent) {
      await _onUpdateBlInstruction(event, emit);
    }
    if (event is CreateBlInstructionFormEvent) {
      await _onCreateBlInstruction(event, emit);
    }

    if (event is BlInstructionFormChangedEvent) {
      await _onBlInstructionFormChanged(event, emit);
    }
    if (event is CancelBlInstructionFormEvent) {
      await _onCancelBlInstructionFormEvent(event, emit);
    }
    if (event is ClearBlInstructionFormEvent) {
      await _onClearBlInstructionForm(event, emit);
    }
    if (event is PickAttachmentEvent) {
      await _onPickAttachment(event, emit);
    }

    if (event is ClearAttachmentEvent) {
      await _onClearAttachment(event, emit);
    }

    if (event is BlInstructionFormHandleFailure) {
      await _onHandleFailure(event, emit);
    }
  }

  final formKey = GlobalKey<FormState>();
  final dealIdController = TextEditingController();
  final numberController = TextEditingController();
  final dateController = TextEditingController();

  _initial(InitialBlInstructionFormEvent event, Emitter<BlInstructionFormState> emit) async {
    if (event.id != null) {
      final either = await getBlInstructionByIdUseCase.call(event.id!);

      either.fold(
        (failure) {
          emit(BlInstructionFormError(failure: failure, id: event.id!));
        },
        (invoice) {
          final attachment = invoice.attachmentUrl;
          emit(BlInstructionFormLoaded(
            blInstruction: invoice,
            updatedMode: true,
            attachmentUrl: attachment.isNotEmpty == true ? some(attachment) : none(),
          ));
        },
      );
    } else {
      emit(const BlInstructionFormLoaded());
    }

    _initializeControllers();
  }

  _initializeControllers() {
    if (state is BlInstructionFormLoaded) {
      final state = this.state as BlInstructionFormLoaded;
      formKey.currentState?.reset();
      dealIdController.text = state.blInstruction?.dealId.toString() ?? '';
      numberController.text = state.blInstruction?.number ?? '';
      dateController.text = (state.blInstruction?.date ?? DateTime.now()).formattedDateYYYYMMDD;
      setupControllersListeners();
      add(BlInstructionFormChangedEvent());
    }
  }

  setupControllersListeners() {
    dealIdController.addListener(() => add(BlInstructionFormChangedEvent()));
    numberController.addListener(() => add(BlInstructionFormChangedEvent()));
    dateController.addListener(() => add(BlInstructionFormChangedEvent()));
  }

  _onBlInstructionFormChanged(BlInstructionFormChangedEvent event, Emitter<BlInstructionFormState> emit) {
    final state = this.state as BlInstructionFormLoaded;
    final formIsNotEmpty = [
      dealIdController.text.isNotEmpty,
      numberController.text.isNotEmpty,
      dateController.text.isNotEmpty,
    ].every((element) => element);

    final isAnyFieldIsNotEmpty = [
      dealIdController.text.isNotEmpty,
      numberController.text.isNotEmpty,
      dateController.text != DateTime.now().formattedDateYYYYMMDD,
      state.pickedAttachment.isSome(),
    ].any((element) => element);

    if (state.updatedMode) {
      final blInstruction = state.blInstruction!;
      final urlChanged = state.attachmentUrl.fold(
        () => blInstruction.attachmentUrl.isNotEmpty,
        (a) => a != blInstruction.attachmentUrl,
      );
      bool isFormChanged = blInstruction.number != numberController.text ||
          blInstruction.dealId != int.tryParse(dealIdController.text) ||
          blInstruction.date.formattedDateYYYYMMDD != dateController.text ||
          state.pickedAttachment.isSome() ||
          urlChanged;

      emit(state.copyWith(
        saveEnabled: formIsNotEmpty && isFormChanged,
        cancelEnabled: isFormChanged,
        clearEnabled: formIsNotEmpty,
      ));
    } else {
      emit(state.copyWith(
        saveEnabled: formIsNotEmpty,
        cancelEnabled: false,
        clearEnabled: isAnyFieldIsNotEmpty,
      ));
    }
  }

  _onSubmitBlInstruction(SubmitBlInstructionFormEvent event, Emitter<BlInstructionFormState> emit) {
    final state = this.state as BlInstructionFormLoaded;
    if (formKey.currentState?.validate() == false) return;
    if (state.updatedMode) {
      add(UpdateBlInstructionFormEvent());
    } else {
      add(CreateBlInstructionFormEvent());
    }
  }

  Future _onCreateBlInstruction(CreateBlInstructionFormEvent event, Emitter<BlInstructionFormState> emit) async {
    final state = this.state as BlInstructionFormLoaded;
    emit(state.copyWith(loading: true));

    final params = CreateBlInsturctionUseCaseParams(
      deleteAttachment: false,
      dealId: int.tryParse(dealIdController.text).toIntOrZero,
      number: numberController.text,
      date: DateTime.tryParse(dateController.text).orDefault,
      attachmentPath: state.pickedAttachment.fold(() => null, (file) => file.path),
    );

    final either = await createBlInstructionUsecase.call(params);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit(
        (state.copyWith(
          failureOrSuccessOption: some(left(failure)),
          blInstruction: state.blInstruction,
        )),
      ),
      (blInstruction) {
        emit(state.copyWith(blInstruction: blInstruction, failureOrSuccessOption: some(right('Shipping Invoice created'))));
      },
    );
  }

  Future _onUpdateBlInstruction(UpdateBlInstructionFormEvent event, Emitter<BlInstructionFormState> emit) async {
    final state = this.state as BlInstructionFormLoaded;

    final deleteAttachment = state.attachmentUrl.isNone() && state.pickedAttachment.isNone();
    final parms = UpdateBlInsturctionUseCaseParams(
      date: DateTime.tryParse(dateController.text).orDefault,
      id: state.blInstruction!.id,
      dealId: int.tryParse(dealIdController.text).toIntOrZero,
      number: numberController.text,
      attachmentPath: state.pickedAttachment.fold(() => null, (file) => file.path),
      deleteAttachment: deleteAttachment,
    );

    emit(state.copyWith(loading: true));
    final either = await updateBlInstructionUsecase.call(parms);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit((state.copyWith(failureOrSuccessOption: some(left(failure))))),
      (blInstruction) {
        emit(state.copyWith(blInstruction: blInstruction, failureOrSuccessOption: some(right('Shipping Invoice updated'))));
        _initializeControllers();
      },
    );
  }

  _onClearBlInstructionForm(ClearBlInstructionFormEvent event, Emitter<BlInstructionFormState> emit) {
    formKey.currentState?.reset();
    dealIdController.clear();
    numberController.clear();
    dateController.text = DateTime.now().formattedDateYYYYMMDD;

    if (state is BlInstructionFormLoaded) {
      final state = this.state as BlInstructionFormLoaded;
      emit(state.copyWith(pickedAttachment: none(), attachmentUrl: none()));
    }
  }

  _onCancelBlInstructionFormEvent(BlInstructionFormEvent event, Emitter<BlInstructionFormState> emit) {
    final state = this.state as BlInstructionFormLoaded;
    if (state.blInstruction != null) {
      emit(
        state.copyWith(
          pickedAttachment: none(),
          attachmentUrl: some(state.blInstruction!.attachmentUrl),
        ),
      );
    }
    _initializeControllers();
  }

  @override
  Future<void> close() {
    dealIdController.dispose();
    numberController.dispose();
    dateController.dispose();
    return super.close();
  }

  _onPickAttachment(PickAttachmentEvent event, Emitter<BlInstructionFormState> emit) async {
    final state = this.state as BlInstructionFormLoaded;
    emit(state.copyWith(pickedAttachment: some(event.file)));
    add(BlInstructionFormChangedEvent());
  }

  _onClearAttachment(ClearAttachmentEvent event, Emitter<BlInstructionFormState> emit) {
    final state = this.state as BlInstructionFormLoaded;
    emit(
      state.copyWith(
        pickedAttachment: none(),
        attachmentUrl: none(),
      ),
    );
    add(BlInstructionFormChangedEvent());
  }

  _onHandleFailure(BlInstructionFormHandleFailure event, Emitter<BlInstructionFormState> emit) async {
    if (state is BlInstructionFormError) {
      final state = this.state as BlInstructionFormError;
      emit(BlInstructionInfoInitial());
      await Future.delayed(const Duration(milliseconds: 300));

      add(InitialBlInstructionFormEvent(id: state.id));
    }
  }
}
