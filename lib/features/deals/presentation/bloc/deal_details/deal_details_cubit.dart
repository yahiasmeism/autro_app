import 'dart:async';

import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/features/deals/domin/use_cases/delete_deal_use_case.dart';
import 'package:autro_app/features/deals/domin/use_cases/get_deal_use_case.dart';
import 'package:autro_app/features/deals/domin/use_cases/update_deal_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../domin/entities/deal_entity.dart';

part 'deal_details_state.dart';

@injectable
class DealDetailsCubit extends Cubit<DealDetailsState> {
  final GetDealUseCase getDealUseCase;
  final UpdateDealUseCase updateDealUseCase;
  final DeleteDealUseCase deleteDealUseCase;
  DealDetailsCubit(this.getDealUseCase, this.updateDealUseCase, this.deleteDealUseCase) : super(DealDetailsInitial());

  final formKey = GlobalKey<FormState>();
  final notesController = TextEditingController();
  final shippingDateController = TextEditingController();
  final deliveryDateController = TextEditingController();
  final etaDateController = TextEditingController();

  init(int dealId) async {
    await getDeal(dealId);
  }

  _initilizeController(DealEntity deal) {
    notesController.text = deal.notes;
    shippingDateController.text = deal.shippingDate?.formattedDateYYYYMMDD ?? '';
    deliveryDateController.text = deal.deliveryDate?.formattedDateYYYYMMDD ?? '';
    etaDateController.text = deal.etaDate?.formattedDateYYYYMMDD ?? '';
  }

  Future getDeal(int dealId) async {
    emit(DealDetailsInitial());
    final dealEither = await getDealUseCase.call(dealId);
    dealEither.fold(
      (failure) => emit(DealDetailsError(failure: failure, dealid: dealId)),
      (deal) {
        emit(DealDetailsLoaded(deal: deal));
        _initilizeController(deal);
        _initProgressValue();
      },
    );
  }

  retry() async {
    final state = this.state as DealDetailsError;
    emit(DealDetailsInitial());
    final dealEither = await getDealUseCase.call(state.dealid);
    dealEither.fold(
      (failure) => emit(DealDetailsError(failure: failure, dealid: state.dealid)),
      (deal) => emit(DealDetailsLoaded(deal: deal)),
    );
  }

  refresh() async {
    if (this.state is! DealDetailsLoaded) return;
    final state = this.state as DealDetailsLoaded;
    emit(state.copyWith(loading: true));

    final dealEither = await getDealUseCase.call(state.deal.id);
    dealEither.fold(
      (failure) => null,
      (deal) => emit(state.copyWith(deal: deal, loading: false)),
    );
  }

  editDeal() {
    final state = this.state as DealDetailsLoaded;
    emit(state.copyWith(updatedMode: true));
  }

  saveDeal() async {
    final state = this.state as DealDetailsLoaded;

    final etaDate = DateTime.tryParse(etaDateController.text.trim());
    final shippingDate = DateTime.tryParse(shippingDateController.text.trim());

    if (etaDate != null && shippingDate != null) {
      if (etaDate.isBefore(shippingDate)) {
        emit(state.copyWith(
            updateFailureOrSuccessOption: some(left(const GeneralFailure(message: 'ETA date must be after shipping date')))));
        return;
      }
    }

    if (!_checkFormIsChanged()) {
      emit(state.copyWith(updatedMode: false));
      return;
    }

    final params = UpdateDealUseCaseParams(
      dealId: state.deal.id,
      delivaryDate: DateTime.tryParse(deliveryDateController.text.trim()),
      etaDate: DateTime.tryParse(etaDateController.text.trim()),
      shippingDate: DateTime.tryParse(shippingDateController.text.trim()),
      notes: notesController.text.trim(),
      isComplete: state.deal.isComplete,
    );

    emit(state.copyWith(loading: true));

    final either = await updateDealUseCase.call(params);

    emit(state.copyWith(loading: false));

    either.fold(
      (failure) => emit(state.copyWith(updateFailureOrSuccessOption: some(left(failure)), updatedMode: false)),
      (deal) => emit(state.copyWith(deal: deal, updatedMode: false, updateFailureOrSuccessOption: some(right('Deal updated')))),
    );
    _initProgressValue();
  }

  bool _checkFormIsChanged() {
    final state = this.state as DealDetailsLoaded;

    final originalDeliveryDate = state.deal.deliveryDate?.formattedDateYYYYMMDD ?? "";
    final originalEtaDate = state.deal.etaDate?.formattedDateYYYYMMDD ?? "";
    final originalShippingDate = state.deal.shippingDate?.formattedDateYYYYMMDD ?? '';
    final originalNotes = state.deal.notes;

    final formChanged = deliveryDateController.text.trim() != originalDeliveryDate ||
        etaDateController.text.trim() != originalEtaDate ||
        shippingDateController.text.trim() != originalShippingDate ||
        notesController.text.trim() != originalNotes;

    return formChanged;
  }

  void _initProgressValue() {
    final state = this.state as DealDetailsLoaded;

    if (state.deal.isComplete) {
      emit(state.copyWith(progress: 1));
    } else {
      final state = this.state as DealDetailsLoaded;
      if (!state.isProgressDurationValid) {
        return;
      }
      final newProgress = _calculateProgress(state.deal.shippingDate!, state.deal.etaDate!);

      emit(state.copyWith(progress: newProgress));

      if (newProgress >= 1.0) {
        updateDealStatus(true);
      }
    }
  }

  double _calculateProgress(DateTime startDate, DateTime endDate) {
    final currentDate = DateTime.now();

    if (currentDate.isBefore(startDate)) return 0.0;
    if (currentDate.isAfter(endDate)) return 1.0;

    final totalDuration = endDate.difference(startDate).inMilliseconds;
    final elapsedDuration = currentDate.difference(startDate).inMilliseconds;

    final progress = elapsedDuration / totalDuration;

    return progress.clamp(0.0, 1.0);
  }

  updateDealStatus(bool isCompleted) async {
    final state = this.state as DealDetailsLoaded;
    if (isCompleted == state.deal.isComplete) return;
    emit(state.copyWith(loading: true));
    final params = UpdateDealUseCaseParams(
      dealId: state.deal.id,
      delivaryDate: state.deal.deliveryDate,
      etaDate: state.deal.etaDate,
      shippingDate: state.deal.shippingDate,
      notes: state.deal.notes,
      isComplete: isCompleted,
    );

    final either = await updateDealUseCase.call(params);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit(state.copyWith(updateFailureOrSuccessOption: some(left(failure)))),
      (deal) => emit(state.copyWith(deal: deal, updateFailureOrSuccessOption: some(right('Deal status updated')))),
    );
  }

  deleteDeal() async {
    final state = this.state as DealDetailsLoaded;
    emit(state.copyWith(loading: true));
    final either = await deleteDealUseCase.call(state.deal.id);
    emit(state.copyWith(loading: false));
    either.fold(
      (failure) => emit(state.copyWith(deleteFailureOrSuccessOption: some(left(failure)))),
      (unit) => emit(state.copyWith(deleteFailureOrSuccessOption: some(right('Deal deleted')))),
    );
  }
}
