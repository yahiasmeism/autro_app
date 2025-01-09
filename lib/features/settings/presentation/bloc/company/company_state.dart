part of 'company_cubit.dart';

sealed class CompanyState extends Equatable {
  const CompanyState();

  @override
  List<Object> get props => [];
}

final class CompanyInitial extends CompanyState {}

final class CompanyLoaded extends CompanyState {
  final CompanyEntity company;
  final Option<Either<Failure, String>> failureOrSuccessOption;
  final bool saveEnabled;
  final bool loading;

  const CompanyLoaded({
    required this.company,
    required this.failureOrSuccessOption,
    required this.loading,
    required this.saveEnabled,
  });

  factory CompanyLoaded.initial(CompanyEntity company) {
    return CompanyLoaded(
      company: company,
      failureOrSuccessOption: none(),
      loading: false,
      saveEnabled: false,
    );
  }

  @override
  List<Object> get props => [
        company,
        loading,
        failureOrSuccessOption,
        saveEnabled,
      ];

  CompanyLoaded copyWith(
      {CompanyEntity? company,
      Option<Either<Failure, String>>? failureOrSuccessOption,
      bool? loading,
      GlobalKey<FormState>? formKey,
      final bool? saveEnabled}) {
    return CompanyLoaded(
      company: company ?? this.company,
      loading: loading ?? this.loading,
      failureOrSuccessOption: failureOrSuccessOption ?? none(),
      saveEnabled: saveEnabled ?? this.saveEnabled,
    );
  }
}

final class CompanyError extends CompanyState {
  final Failure failure;

  const CompanyError(this.failure);

  @override
  List<Object> get props => [failure];
}
