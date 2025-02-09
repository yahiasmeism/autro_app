import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/di/di.dart';
import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/utils/file_utils.dart';
import 'package:autro_app/core/utils/nav_util.dart';
import 'package:autro_app/core/widgets/app_pdf_viewer.dart';
import 'package:autro_app/core/widgets/failure_screen.dart';
import 'package:autro_app/core/widgets/loading_indecator.dart';
import 'package:autro_app/features/invoices/domin/dtos/invoice_pdf_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../core/theme/text_styles.dart';
import '../bloc/invoice_pdf/invoice_pdf_cubit.dart';

class InvoicePdfScreen extends StatelessWidget {
  const InvoicePdfScreen._();

  static create(BuildContext context, InvoicePdfDto dto, {PdfAction action = PdfAction.view, String? filePath}) {
    NavUtil.push(
      context,
      BlocProvider<InvoicePdfCubit>(
        create: (context) => sl<InvoicePdfCubit>()..init(dto, action: action, saveFilePath: filePath),
        child: const InvoicePdfScreen._(),
      ),
    );
  }

  PdfColor get textColor => const PdfColor.fromInt(0xff083156);
  PdfColor get tableHeaderColor => PdfColors.grey100;
  PdfColor get tableBorderColor => PdfColors.grey400;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InvoicePdfCubit, InvoicePdfState>(
      listener: listener,
      builder: (context, state) {
        if (state is InvoicePdfInitial) {
          return const LoadingIndicator();
        } else if (state is InvoicePdfResourcesLoading) {
          return const LoadingIndicator(loadingMessage: 'Preparing resoures...');
        } else if (state is InvoicePdfGenerating) {
          return const LoadingIndicator(loadingMessage: 'Generating...');
        } else if (state is InvoicePdfGenerated) {
          return AppPdfViewer(localPath: state.pdfPath);
        } else if (state is ExportInvoiceLoading) {
          return const LoadingIndicator(loadingMessage: 'Exporting..');
        } else if (state is InvoicePdfError) {
          return Center(child: Scaffold(appBar: AppBar(), body: FailureScreen(failure: state.failure)));
        }
        return const SizedBox.shrink();
      },
    );
  }

  void listener(BuildContext context, InvoicePdfState state) {
    if (state is InvoicePdfResourcesLoaded) {
      final invoiceContent = _buildInvoicePdfContent(state);
      if (state.action == PdfAction.view) {
        context.read<InvoicePdfCubit>().generateInvoicePdf(invoiceContent);
      } else if (state.action == PdfAction.export) {
        context.read<InvoicePdfCubit>().exportInvoicePdf(state.filePath!, invoiceContent);
      }
    }
    if (state is ExportInvoiceDone) {
      DialogUtil.showSuccessSnackBar(
          context,
          'Invoice saved successfully as: ${state.filePath.split('/').last}',
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              FileUtils.openFolder(state.filePath);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                'show',
                style: TextStyles.font16Regular,
              ),
            ),
          ));
      NavUtil.pop(context);
    }
  }

  pw.Page _buildInvoicePdfContent(InvoicePdfResourcesLoaded state) {
    return pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(40),
      build: (context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            buildHeader(state),
            pw.SizedBox(height: 25),
            buildCompanyInfo(state),
            pw.SizedBox(height: 16),
            buildMainTable(state),
            pw.SizedBox(height: 0),
            buildSummaryTable(state),
            pw.SizedBox(height: 20),
            buildNotes(state),
            pw.Spacer(),
            buildFooter(state),
            pw.SizedBox(height: 20),
          ],
        );
      },
    );
  }

  pw.Widget buildHeader(InvoicePdfResourcesLoaded state) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Image(
          state.logoImageProvider,
          width: 180,
          height: 45,
          dpi: 3000,
        ),
        pw.Text(
          "INVOICE",
          style: pw.TextStyle(
            fontSize: 28,
            color: textColor,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      ],
    );
  }

  pw.Widget buildCompanyInfo(InvoicePdfResourcesLoaded state) {
    final style = pw.TextStyle(
      color: textColor,
      fontSize: 12,
      fontWeight: pw.FontWeight.bold,
    );

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text("From: ${state.company.name}", style: style),
        pw.SizedBox(height: 4),
        pw.Text("Address: ${state.company.address}", style: style),
        pw.SizedBox(height: 2),
        pw.Text("VAT: ${state.company.vat}", style: style),
        pw.SizedBox(height: 8),
        pw.Divider(height: 0.5, color: tableBorderColor),
        pw.SizedBox(height: 8),
        pw.Text("To: ${state.invoicePdfDto.customerName}", style: style),
        pw.SizedBox(height: 2),
        pw.Text("Address: ${state.invoicePdfDto.customerAddress}", style: style),
        pw.SizedBox(height: 2),
        pw.Text("TAX ID: ${state.invoicePdfDto.taxId}", style: style),
        pw.SizedBox(height: 8),
        pw.Divider(height: 0.5, color: tableBorderColor),
        pw.SizedBox(height: 8),
        pw.Row(children: [
          pw.Text(
            "Invoice Number: INV${state.invoicePdfDto.invoiceNumber}",
            style: pw.TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.Spacer(),
          pw.Text(
            "Invoice Date: ${state.invoicePdfDto.date.formattedDateDDMMYYYY}",
            style: pw.TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ]),
      ],
    );
  }

  pw.Widget buildMainTable(InvoicePdfResourcesLoaded state) {
    final headers = [
      'Description',
      'Container Number',
      'Weight (MT)',
      'Unit Price (EUR)',
      'Total Pirce (EUR)',
    ];

    final data = state.invoicePdfDto.descriptions
        .map((e) => [e.description, e.containerNumber, e.weight, e.unitPrice, e.totalPrice])
        .toList();

    return pw.TableHelper.fromTextArray(
      border: pw.TableBorder.all(
        color: tableBorderColor,
        width: 0.5,
      ),
      headerStyle: pw.TextStyle(
        fontWeight: pw.FontWeight.bold,
        color: textColor,
        fontSize: 10,
      ),
      headerDecoration: pw.BoxDecoration(
        color: tableHeaderColor,
      ),
      headerHeight: 25,
      cellStyle: pw.TextStyle(
        fontSize: 10,
        lineSpacing: 1,
        color: textColor,
      ),
      cellHeight: 25,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.center,
        2: pw.Alignment.center,
        3: pw.Alignment.center,
        4: pw.Alignment.center,
      },
      headerAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.center,
        2: pw.Alignment.center,
        3: pw.Alignment.center,
        4: pw.Alignment.center,
      },
      headers: headers,
      data: data,
    );
  }

  pw.Widget buildSummaryTable(InvoicePdfResourcesLoaded state) {
    final headers = [
      'Origin Of Goods',
      'Containers Count',
      'Total Weight (MT)',
      'Total Amount EUR',
    ];

    final data = [
      [
        'Spain',
        state.invoicePdfDto.descriptions.length.toString(),
        '${state.invoicePdfDto.totalWeight} MT',
        '${state.invoicePdfDto.totalAmount} EUR',
      ],
    ];

    return pw.TableHelper.fromTextArray(
      border: pw.TableBorder.all(
        color: tableBorderColor,
        width: 0.5,
      ),
      headerStyle: pw.TextStyle(
        fontWeight: pw.FontWeight.bold,
        color: textColor,
        fontSize: 10,
      ),
      headerDecoration: pw.BoxDecoration(
        color: tableHeaderColor,
      ),
      headerHeight: 25,
      cellStyle: pw.TextStyle(
        fontSize: 10,
        color: textColor,
      ),
      cellHeight: 25,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.center,
        2: pw.Alignment.center,
        3: pw.Alignment.center,
      },
      headerAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.center,
        2: pw.Alignment.center,
        3: pw.Alignment.center,
      },
      headers: headers,
      data: data,
    );
  }

  pw.Widget buildNotes(InvoicePdfResourcesLoaded state) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Notes:',
          style: pw.TextStyle(
            color: textColor,
            fontSize: 12,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 5),
        pw.Text(
          state.invoicePdfDto.notes,
          style: pw.TextStyle(fontSize: 10, color: textColor),
        ),
      ],
    );
  }

  pw.Widget buildFooter(InvoicePdfResourcesLoaded state) {
    final style = pw.TextStyle(
      color: textColor,
      fontSize: 12,
      // fontWeight: pw.FontWeight.bold,
    );
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Bank Details:',
                style: pw.TextStyle(
                  color: PdfColors.red,
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 5),
              pw.Text('Bank Name: ${state.invoicePdfDto.bankName}', style: style),
              pw.SizedBox(height: 3),
              pw.Text('IBAN EURO: ${state.invoicePdfDto.bankAccountNumber}', style: style),
              pw.SizedBox(height: 3),
              pw.Text('SWIFT BIC: ${state.invoicePdfDto.swiftCode}', style: style),
              pw.SizedBox(height: 3),
              pw.Text('Beneficiary: ${state.company.name}', style: style),
            ],
          ),
        ),
        pw.SizedBox(width: 40),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text(
              'Seller Signature:',
              style: pw.TextStyle(
                color: PdfColors.blue900,
                fontSize: 11,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 10),
            pw.Image(state.signatureImageProvider, width: 150, height: 70, dpi: 3000),
          ],
        ),
      ],
    );
  }
}
