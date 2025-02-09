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
  final InvoiceSettingsEntity invoiceSettings;

  const ProformaPdfResourcesLoaded({
    required this.logoImageProvider,
    required this.invoiceSettings,
    required this.signatureImageProvider,
    required this.company,
    required this.proformaPdfDto,
    required this.action,
    this.filePath,
  });

  @override
  List<Object?> get props => [logoImageProvider, signatureImageProvider, company, proformaPdfDto, action, filePath,invoiceSettings];
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
  final String customerName;
  final String customerAddress;
  final String taxId;
  final DateTime proformaDate;

  final String delivartLocation;
  final String paymentTerms;
  final String delivaryTerms;
  final List<ProformaGoodDescriptionDto> descriptions;
  final String bankName;
  final String accountNumber;
  final String swift;

  ProformaPdfDto(
      {required this.proformaNumber,
      required this.customerName,
      required this.customerAddress,
      required this.taxId,
      required this.proformaDate,
      required this.delivartLocation,
      required this.paymentTerms,
      required this.delivaryTerms,
      required this.descriptions,
      required this.bankName,
      required this.accountNumber,
      required this.swift});
  double get totalWeight => descriptions.fold<double>(
        0,
        (previousValue, element) => previousValue + element.weight,
      );

  double get totalAmount => descriptions.fold<double>(
        0,
        (previousValue, element) => previousValue + (element.unitPrice * element.weight),
      );
}
