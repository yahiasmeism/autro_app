part of 'packing_list_pdf_cubit.dart';

sealed class PackingListPdfState extends Equatable {
  const PackingListPdfState();

  @override
  List<Object?> get props => [];
}

final class PackingListPdfInitial extends PackingListPdfState {}

final class PackingListPdfResourcesLoading extends PackingListPdfState {}

final class PackingListPdfResourcesLoaded extends PackingListPdfState {
  final pw.ImageProvider logoImageProvider;
  final pw.ImageProvider signatureImageProvider;
  final CompanyEntity company;
  final PackingListPdfDto packingListPdfDto;
  final PdfAction action;
  final String? filePath;

  const PackingListPdfResourcesLoaded({
    required this.logoImageProvider,
    required this.signatureImageProvider,
    required this.company,
    required this.packingListPdfDto,
    required this.action,
    this.filePath,
  });

  @override
  List<Object?> get props => [logoImageProvider, signatureImageProvider, company, packingListPdfDto, action, filePath];
}

final class PackingListPdfGenerating extends PackingListPdfState {}

final class PackingListPdfGenerated extends PackingListPdfState {
  final String pdfPath;

  const PackingListPdfGenerated({required this.pdfPath});

  @override
  List<Object> get props => [pdfPath];
}

final class PackingListPdfError extends PackingListPdfState {
  final Failure failure;

  const PackingListPdfError({required this.failure});
}

final class ExportPackingListLoading extends PackingListPdfState {}

final class ExportPackingListDone extends PackingListPdfState {
  final String filePath;

  const ExportPackingListDone({required this.filePath});
}
