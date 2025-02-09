import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/di/di.dart';
import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/utils/nav_util.dart';
import 'package:autro_app/core/widgets/app_pdf_viewer.dart';
import 'package:autro_app/core/widgets/failure_screen.dart';
import 'package:autro_app/core/widgets/loading_indecator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/file_utils.dart';
import '../bloc/proforma_pdf/proforma_pdf_cubit.dart';

class ProformaPdfScreen extends StatelessWidget {
  const ProformaPdfScreen._();

  static create(BuildContext context, ProformaPdfDto dto, {PdfAction action = PdfAction.view, String? filePath}) {
    NavUtil.push(
      context,
      BlocProvider<ProformaPdfCubit>(
        create: (context) => sl<ProformaPdfCubit>()..init(dto, action: action, saveFilePath: filePath),
        child: const ProformaPdfScreen._(),
      ),
    );
  }

  PdfColor get textColor => const PdfColor.fromInt(0xff083156);
  PdfColor get tableHeaderColor => PdfColors.grey100;
  PdfColor get tableBorderColor => PdfColors.grey400;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProformaPdfCubit, ProformaPdfState>(
      listener: listener,
      builder: (context, state) {
        if (state is ProformaPdfInitial) {
          return const LoadingIndicator();
        } else if (state is ProformaPdfResourcesLoading) {
          return const LoadingIndicator(loadingMessage: 'Preparing resoures...');
        } else if (state is ProformaPdfGenerating) {
          return const LoadingIndicator(loadingMessage: 'Generating...');
        } else if (state is ProformaPdfGenerated) {
          return AppPdfViewer(localPath: state.pdfPath);
        } else if (state is ExportProformaLoading) {
          return const LoadingIndicator(loadingMessage: 'Exporting..');
        } else if (state is ProformaPdfError) {
          return Center(child: Scaffold(appBar: AppBar(), body: FailureScreen(failure: state.failure)));
        }
        return const SizedBox.shrink();
      },
    );
  }

  void listener(BuildContext context, ProformaPdfState state) {
    if (state is ProformaPdfResourcesLoaded) {
      final proformaContent = _buildProformaPdfContent(state);
      if (state.action == PdfAction.view) {
        context.read<ProformaPdfCubit>().generateProformaPdf(proformaContent);
      } else if (state.action == PdfAction.export) {
        context.read<ProformaPdfCubit>().exportProformaPdf(state.filePath!, proformaContent);
      }
    }
    if (state is ExportProformaDone) {
      DialogUtil.showSuccessSnackBar(
          context,
          'Proforma saved successfully as: ${state.filePath.split('/').last}',
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

  pw.Page _buildProformaPdfContent(ProformaPdfResourcesLoaded state) {
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
            pw.SizedBox(height: 25),
            buildMainTable(state),
            pw.SizedBox(height: 0),
            buildSummaryTable(state),
            pw.SizedBox(height: 10),
            _buildExempt(state),
            pw.SizedBox(height: 15),
            buildLoadingConditions(state),
            pw.Spacer(),
            buildFooter(state),
          ],
        );
      },
    );
  }

  pw.Widget buildHeader(ProformaPdfResourcesLoaded state) {
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
          "PROFORMA",
          style: pw.TextStyle(
            fontSize: 28,
            color: textColor,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      ],
    );
  }

  pw.Widget _buildExempt(ProformaPdfResourcesLoaded state) {
    final style = pw.TextStyle(
      color: textColor,
      fontSize: 12,
      fontWeight: pw.FontWeight.bold,
    );
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text("Exempt: ", style: style),
        pw.Expanded(
          child: pw.Text(
            state.invoiceSettings.exempt,
            style: style.copyWith(fontWeight: pw.FontWeight.normal),
          ),
        ),
      ],
    );
  }

  pw.Widget buildCompanyInfo(ProformaPdfResourcesLoaded state) {
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
        pw.Text("To: ${state.proformaPdfDto.customerName}", style: style),
        pw.SizedBox(height: 2),
        pw.Text("Address: ${state.proformaPdfDto.customerAddress}", style: style),
        pw.SizedBox(height: 2),
        pw.Text("TAX ID: ${state.proformaPdfDto.taxId}", style: style),
        pw.SizedBox(height: 8),
        pw.Divider(height: 0.5, color: tableBorderColor),
        pw.SizedBox(height: 8),
        pw.Row(children: [
          pw.Text(
            "Proforma Number: INV${state.proformaPdfDto.proformaNumber}",
            style: pw.TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.Spacer(),
          pw.Text(
            "Proforma Date: ${state.proformaPdfDto.proformaDate.formattedDateDDMMYYYY}",
            style: pw.TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ]),
        pw.SizedBox(height: 4),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("Delivery Location: ", style: style),
            pw.Expanded(
              child: pw.Text(
                state.proformaPdfDto.delivartLocation,
                style: style.copyWith(fontWeight: pw.FontWeight.normal),
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 4),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("Delivery Terms: ", style: style),
            pw.Expanded(
              child: pw.Text(
                state.proformaPdfDto.delivaryTerms,
                style: style.copyWith(fontWeight: pw.FontWeight.normal),
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 4),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("Payment Terms: ", style: style),
            pw.Expanded(
              child: pw.Text(
                state.proformaPdfDto.paymentTerms,
                style: style.copyWith(fontWeight: pw.FontWeight.normal),
              ),
            ),
          ],
        ),
      ],
    );
  }

  pw.Widget buildMainTable(ProformaPdfResourcesLoaded state) {
    final headers = [
      'Description',
      'Weight (MT)',
      'Unit Price (EUR)',
      'Packing',
      'Total Pirce (EUR)',
    ];

    final data =
        state.proformaPdfDto.descriptions.map((e) => [e.description, e.weight, e.unitPrice, e.packing, e.totalPrice]).toList();

    return pw.TableHelper.fromTextArray(
      border: pw.TableBorder.all(
        color: tableBorderColor,
        width: 0.5,
      ),
      headerStyle: pw.TextStyle(
        fontWeight: pw.FontWeight.bold,
        color: textColor,
        fontSize: 12,
      ),
      headerDecoration: pw.BoxDecoration(
        color: tableHeaderColor,
      ),
      headerHeight: 25,
      cellStyle: pw.TextStyle(
        fontSize: 12,
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

  pw.Widget buildSummaryTable(ProformaPdfResourcesLoaded state) {
    final headers = [
      'Origin Of Goods',
      'Containers Count',
      'Total Weight (MT)',
      'Total Amount EUR',
    ];

    final data = [
      [
        'Spain',
        state.proformaPdfDto.descriptions.length.toString(),
        '${state.proformaPdfDto.totalWeight} MT',
        '${state.proformaPdfDto.totalAmount} EUR',
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
        fontSize: 12,
      ),
      headerDecoration: pw.BoxDecoration(
        color: tableHeaderColor,
      ),
      headerHeight: 25,
      cellStyle: pw.TextStyle(
        fontSize: 12,
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

  pw.Widget buildLoadingConditions(ProformaPdfResourcesLoaded state) {
    final style = pw.TextStyle(
      color: textColor,
      fontSize: 12,
      // fontWeight: pw.FontWeight.bold,
    );
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Loading Conditions:',
            style: pw.TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
            )),
        pw.SizedBox(height: 6),
        pw.Row(children: [
          pw.Text('Shipping Instructions: ', style: style),
          pw.Expanded(
            child: pw.Text(
              state.invoiceSettings.shippingInstructions,
              style: style,
            ),
          ),
        ]),
        pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Text('Loading date: ', style: style),
          pw.Expanded(
            child: pw.Text(
              state.invoiceSettings.loadingDate,
              style: style,
            ),
          ),
        ]),
        pw.Row(
          children: [
            pw.Text('Type of transport: ', style: style),
            pw.Expanded(
              child: pw.Text(
                state.invoiceSettings.typeOfTransport,
                style: style,
              ),
            ),
          ],
          crossAxisAlignment: pw.CrossAxisAlignment.start,
        ),
        pw.Row(
          children: [
            pw.Text('Modifications on BL: ', style: style),
            pw.Expanded(
              child: pw.Text(
                state.invoiceSettings.modificationOnBl,
                style: style,
              ),
            ),
          ],
          crossAxisAlignment: pw.CrossAxisAlignment.start,
        ),
        pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Text('Special conditions: ', style: style),
          pw.Expanded(
            child: pw.Text(
              state.invoiceSettings.specialConditions,
              style: style,
            ),
          ),
        ]),
        pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Text('Loading Pictures: ', style: style),
          pw.Expanded(
            child: pw.Text(
              state.invoiceSettings.loadingPictures,
              style: style,
            ),
          ),
        ])
      ],
    );
  }

  pw.Widget buildFooter(ProformaPdfResourcesLoaded state) {
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
              pw.Text('Bank Name: ${state.proformaPdfDto.bankName}', style: style),
              pw.SizedBox(height: 3),
              pw.Text('IBAN EURO: ${state.proformaPdfDto.accountNumber}', style: style),
              pw.SizedBox(height: 3),
              pw.Text('SWIFT BIC: ${state.proformaPdfDto.swift}', style: style),
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
