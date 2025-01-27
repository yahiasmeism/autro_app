part of 'invoice_pdf_cubit.dart';

sealed class InvoicePdfState extends Equatable {
  const InvoicePdfState();

  @override
  List<Object> get props => [];
}

final class InvoicePdfInitial extends InvoicePdfState {}

final class InvoicePdfResourcesLoaded extends InvoicePdfState {
  final pw.ImageProvider logoImageProvider;
  final pw.ImageProvider signatureImageProvider;

  const InvoicePdfResourcesLoaded({required this.logoImageProvider, required this.signatureImageProvider});

  @override
  List<Object> get props => [logoImageProvider, signatureImageProvider];
}

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
