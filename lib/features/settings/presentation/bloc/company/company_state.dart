part of 'company_cubit.dart';

sealed class CompanyState extends Equatable {
  const CompanyState();

  @override
  List<Object?> get props => [];
}

final class CompanyInitial extends CompanyState {}

final class CompanyLoaded extends CompanyState {
  final CompanyEntity company;
  final Option<Either<Failure, String>> failureOrSuccessOption;
  final bool dataChanged;
  final bool loading;
  final Option<File> pickedLogoFile;
  final Option<File> pickedSignatureFile;

  const CompanyLoaded({
    required this.company,
    required this.failureOrSuccessOption,
    required this.loading,
    required this.dataChanged,
    required this.pickedLogoFile,
    required this.pickedSignatureFile,
  });

  factory CompanyLoaded.initial(CompanyEntity company) {
    return CompanyLoaded(
      company: company,
      failureOrSuccessOption: none(),
      loading: false,
      dataChanged: false,
      pickedLogoFile: none(),
      pickedSignatureFile: none(),
    );
  }

  @override
  List<Object?> get props => [company, loading, failureOrSuccessOption, dataChanged, pickedLogoFile, pickedSignatureFile];

  CompanyLoaded copyWith({
    CompanyEntity? company,
    Option<Either<Failure, String>>? failureOrSuccessOption,
    bool? loading,
    GlobalKey<FormState>? formKey,
    final bool? dataChanged,
    Option<File>? pickedLogoFile,
    Option<File>? pickedSignatureFile,
  }) {
    return CompanyLoaded(
      company: company ?? this.company,
      loading: loading ?? this.loading,
      failureOrSuccessOption: failureOrSuccessOption ?? none(),
      dataChanged: dataChanged ?? this.dataChanged,
      pickedLogoFile: pickedLogoFile ?? this.pickedLogoFile,
      pickedSignatureFile: pickedSignatureFile ?? this.pickedSignatureFile,
    );
  }
}

final class CompanyError extends CompanyState {
  final Failure failure;

  const CompanyError(this.failure);

  @override
  List<Object> get props => [failure];
}
