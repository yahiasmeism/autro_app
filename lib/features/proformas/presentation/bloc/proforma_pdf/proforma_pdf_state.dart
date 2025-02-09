part of 'proforma_pdf_cubit.dart';

sealed class ProformaPdfState extends Equatable {
  const ProformaPdfState();

  @override
  List<Object?> get props => [];
}

final class ProformaPdfInitial extends ProformaPdfState {}

final class ProformaPdfResourcesLoading extends ProformaPdfState {}

final class ProformaPdfResourcesLoaded extends ProformaPdfState {
  final pw.ImageProvider logoImageProvider;
  final pw.ImageProvider signatureImageProvider;
  final CompanyEntity company;
  final ProformaPdfDto proformaPdfDto;
  final PdfAction action;
  final String? filePath;

  const ProformaPdfResourcesLoaded({
    required this.logoImageProvider,
    required this.signatureImageProvider,
    required this.company,
    required this.proformaPdfDto,
    required this.action,
    this.filePath,
  });

  @override
  List<Object?> get props => [logoImageProvider, signatureImageProvider, company, proformaPdfDto, action, filePath];
}

final class ProformaPdfGenerating extends ProformaPdfState {}

final class ProformaPdfGenerated extends ProformaPdfState {
  final String pdfPath;

  const ProformaPdfGenerated({required this.pdfPath});

  @override
  List<Object> get props => [pdfPath];
}

final class ProformaPdfError extends ProformaPdfState {
  final Failure failure;

  const ProformaPdfError({required this.failure});
}

final class ExportProformaLoading extends ProformaPdfState {}

final class ExportProformaDone extends ProformaPdfState {
  final String filePath;

  const ExportProformaDone({required this.filePath});
}

class ProformaPdfDto {
  final String proformaNumber;
  final List<ProformaGoodDescriptionDto> descriptions;

  ProformaPdfDto({required this.proformaNumber,required this.descriptions});
}
