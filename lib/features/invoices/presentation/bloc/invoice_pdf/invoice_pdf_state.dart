part of 'invoice_pdf_cubit.dart';

sealed class InvoicePdfState extends Equatable {
  const InvoicePdfState();

  @override
  List<Object?> get props => [];
}

final class InvoicePdfInitial extends InvoicePdfState {}

final class InvoicePdfResourcesLoading extends InvoicePdfState {}

final class InvoicePdfResourcesLoaded extends InvoicePdfState {
  final pw.ImageProvider logoImageProvider;
  final pw.ImageProvider signatureImageProvider;
  final CompanyEntity company;
  final InvoicePdfDto invoicePdfDto;
  final PdfAction action;
  final String? filePath;

  const InvoicePdfResourcesLoaded({
    required this.logoImageProvider,
    required this.signatureImageProvider,
    required this.company,
    required this.invoicePdfDto,
    required this.action,
    this.filePath,
  });

  @override
  List<Object?> get props => [logoImageProvider, signatureImageProvider, company, invoicePdfDto, action, filePath];
}

final class InvoicePdfGenerating extends InvoicePdfState {}

final class InvoicePdfGenerated extends InvoicePdfState {
  final String pdfPath;

  const InvoicePdfGenerated({required this.pdfPath});

  @override
  List<Object> get props => [pdfPath];
}

final class InvoicePdfError extends InvoicePdfState {
  final Failure failure;

  const InvoicePdfError({required this.failure});
}

final class ExportInvoiceLoading extends InvoicePdfState {}

final class ExportInvoiceDone extends InvoicePdfState {
  final String filePath;

  const ExportInvoiceDone({required this.filePath});
}
