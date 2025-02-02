import 'package:autro_app/core/di/di.dart';
import 'package:autro_app/core/utils/nav_util.dart';
import 'package:autro_app/core/widgets/app_pdf_viewer.dart';
import 'package:autro_app/core/widgets/failure_screen.dart';
import 'package:autro_app/features/invoices/domin/dtos/invoice_pdf_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../bloc/invoice_pdf/invoice_pdf_cubit.dart';

class InvoicePdfScreen extends StatelessWidget {
  const InvoicePdfScreen._();

  static create(BuildContext context, InvoicePdfDto dto) {
    NavUtil.push(
      context,
      BlocProvider<InvoicePdfCubit>(
        create: (context) => sl<InvoicePdfCubit>()..init(dto),
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
      buildWhen: (previous, current) => current is InvoicePdfGenerated || current is InvoicePdfError,
      builder: (context, state) {
        if (state is InvoicePdfInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is InvoicePdfGenerated) {
          return AppPdfViewer(localPath: state.pdfPath);
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
      context.read<InvoicePdfCubit>().generateInvoicePdf(invoiceContent);
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
            buildCompanyInfo(),
            pw.SizedBox(height: 25),
            buildMainTable(),
            pw.SizedBox(height: 0),
            buildSummaryTable(),
            pw.SizedBox(height: 20),
            buildNotes(),
            pw.SizedBox(height: 20),
            buildFooter(state),
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
          "INVOICE: INV0146",
          style: pw.TextStyle(
            fontSize: 20,
            color: textColor,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      ],
    );
  }

  pw.Widget buildCompanyInfo() {
    final style = pw.TextStyle(
      color: textColor,
      fontSize: 10,
    );

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text("From: TRICYCLE PRODUCTS, S.L", style: style),
        pw.Text("Address: PEREZ DOLZ, 8, ENTRS. 12003 Castellon – SPAIN", style: style),
        pw.Text("VAT: B56194830", style: style),
        pw.SizedBox(height: 8),
        pw.Divider(height: 0.5, color: tableBorderColor),
        pw.SizedBox(height: 8),
        pw.Text("To: LAO QIXIN CO.,LTD.", style: style),
        pw.Text("Address: PHONKHAM VILLAGE, KEOUDOM DISTRICT, VIENTIANE PROVINCE. LAO PDR", style: style),
        pw.Text("TAX ID: 662330283-9-00", style: style),
        pw.SizedBox(height: 8),
        pw.Divider(height: 0.5, color: tableBorderColor),
        pw.SizedBox(height: 8),
        pw.Text(
          "Invoice Date: 28/11/2024",
          style: pw.TextStyle(
            color: textColor,
            fontSize: 11,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      ],
    );
  }

  pw.Widget buildMainTable() {
    final headers = [
      'Description',
      'Container Number',
      'Weight (MT)',
      'Unit Price (€)',
      'Total Value (€)',
    ];

    final data = List.generate(
      11,
      (index) => [
        'HDPE PLASTIC SCRAP',
        'MRKU5526291',
        '19,14',
        '320 EUR',
        '6.124,80 € EUR',
      ],
    );

    return pw.TableHelper.fromTextArray(
      border: pw.TableBorder.all(
        color: tableBorderColor,
        width: 0.5,
      ),
      headerStyle: pw.TextStyle(
        fontWeight: pw.FontWeight.bold,
        color: PdfColors.black,
        fontSize: 10,
      ),
      headerDecoration: pw.BoxDecoration(
        color: tableHeaderColor,
      ),
      headerHeight: 25,
      cellStyle: const pw.TextStyle(
        fontSize: 10,
        lineSpacing: 1,
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

  pw.Widget buildSummaryTable() {
    final headers = [
      'Origin Of Goods',
      'Containers Count',
      'Total Weight (MT)',
      'Total Amount EUR',
    ];

    final data = [
      [
        'Spain',
        '4',
        '51,93 MT',
        '19.250,00 EUR',
      ],
    ];

    return pw.TableHelper.fromTextArray(
      border: pw.TableBorder.all(
        color: tableBorderColor,
        width: 0.5,
      ),
      headerStyle: pw.TextStyle(
        fontWeight: pw.FontWeight.bold,
        color: PdfColors.black,
        fontSize: 10,
      ),
      headerDecoration: pw.BoxDecoration(
        color: tableHeaderColor,
      ),
      headerHeight: 25,
      cellStyle: const pw.TextStyle(
        fontSize: 10,
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

  pw.Widget buildNotes() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Notes:',
          style: pw.TextStyle(
            color: textColor,
            fontSize: 11,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 5),
        pw.Text(
          'INVO0149 HDPE PLASTIC SCRAP HS CODE 39151020 - CFR MERSIN PORT: TURKEY CONSIGNEE: OZ BESLENEN TARIM URUNLERI NAK. PET.TEKS. SAN VE TIC LTD STI. AKCATAS MAH. 1 CAD, NO:11-1 VIRANSEHIR/SANLIURBA)',
          style: const pw.TextStyle(fontSize: 9),
        ),
      ],
    );
  }

  pw.Widget buildFooter(InvoicePdfResourcesLoaded state) {
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
                  fontSize: 11,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 5),
              pw.Text('Bank Name: Banco Santander S.A', style: const pw.TextStyle(fontSize: 9)),
              pw.Text('IBAN EURO: ES400049533812210008708', style: const pw.TextStyle(fontSize: 9)),
              pw.Text('SWIFT BIC: BSCHESMM', style: const pw.TextStyle(fontSize: 9)),
              pw.Text('Beneficiary: TRICYCLE PRODUCTS S.L.', style: const pw.TextStyle(fontSize: 9)),
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
