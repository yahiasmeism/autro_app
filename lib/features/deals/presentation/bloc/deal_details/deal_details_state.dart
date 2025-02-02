part of 'deal_details_cubit.dart';

sealed class DealDetailsState extends Equatable {
  const DealDetailsState();

  @override
  List<Object> get props => [];
}

final class DealDetailsInitial extends DealDetailsState {}

final class DealDetailsLoaded extends DealDetailsState {
  final DealEntity deal;
  final bool updatedMode;
  final double progress;
  final bool loading;
  final Option<Either<Failure, String>> updateFailureOrSuccessOption;
  final Option<Either<Failure, String>> deleteFailureOrSuccessOption;
  const DealDetailsLoaded({
    this.progress = 0,
    required this.deal,
    this.updatedMode = false,
    this.loading = false,
    this.updateFailureOrSuccessOption = const None(),
    this.deleteFailureOrSuccessOption = const None(),
  });

  @override
  List<Object> get props => [
        deal,
        updatedMode,
        loading,
        updateFailureOrSuccessOption,
        deleteFailureOrSuccessOption,
        progress,
      ];

  DealDetailsLoaded copyWith({
    DealEntity? deal,
    bool? updatedMode,
    bool? loading,
    Option<Either<Failure, String>>? updateFailureOrSuccessOption,
    Option<Either<Failure, String>>? deleteFailureOrSuccessOption,
    double? progress,
  }) {
    return DealDetailsLoaded(
      progress: progress ?? this.progress,
      deal: deal ?? this.deal,
      updatedMode: updatedMode ?? this.updatedMode,
      loading: loading ?? this.loading,
      updateFailureOrSuccessOption: updateFailureOrSuccessOption ?? none(),
      deleteFailureOrSuccessOption: deleteFailureOrSuccessOption ?? none(),
    );
  }

  bool get isEtaDateBeforeShippingDate => isProgressDurationValid && deal.etaDate!.isBefore(deal.shippingDate!);
  bool get isProgressDurationValid => deal.etaDate != null && deal.shippingDate != null;
}

class DealDetailsError extends DealDetailsState {
  final Failure failure;
  final int dealid;

  const DealDetailsError({required this.failure, required this.dealid});

  @override
  List<Object> get props => [failure, dealid];
}
