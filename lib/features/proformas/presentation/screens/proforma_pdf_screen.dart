import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/di/di.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/utils/nav_util.dart';
import 'package:autro_app/core/widgets/app_pdf_viewer.dart';
import 'package:autro_app/core/widgets/failure_screen.dart';
import 'package:autro_app/core/widgets/loading_indecator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

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
      );
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
            // buildHeader(state),
            // pw.SizedBox(height: 25),
            // buildCompanyInfo(state),
            // pw.SizedBox(height: 25),
            // buildMainTable(state),
            // pw.SizedBox(height: 0),
            // buildSummaryTable(state),
            // pw.SizedBox(height: 20),
            // buildNotes(state),
            // pw.SizedBox(height: 20),
            // buildFooter(state),
          ],
        );
      },
    );
  }

  // pw.Widget buildHeader(ProformaPdfResourcesLoaded state) {
  //   return pw.Row(
  //     mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //     children: [
  //       pw.Image(
  //         state.logoImageProvider,
  //         width: 180,
  //         height: 45,
  //         dpi: 3000,
  //       ),
  //       pw.Text(
  //         "INVOICE: INV${state.proformaPdfDto.proformaNumber}",
  //         style: pw.TextStyle(
  //           fontSize: 24,
  //           color: textColor,
  //           fontWeight: pw.FontWeight.bold,
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // pw.Widget buildCompanyInfo(ProformaPdfResourcesLoaded state) {
  //   final style = pw.TextStyle(
  //     color: textColor,
  //     fontSize: 10,
  //   );

  //   return pw.Column(
  //     crossAxisAlignment: pw.CrossAxisAlignment.start,
  //     children: [
  //       pw.Text("From: ${state.company.name}", style: style),
  //       pw.Text("Address: ${state.company.address}", style: style),
  //       pw.Text("VAT: B56194830", style: style),
  //       pw.SizedBox(height: 8),
  //       pw.Divider(height: 0.5, color: tableBorderColor),
  //       pw.SizedBox(height: 8),
  //       pw.Text("To: ${state.proformaPdfDto.customerName}", style: style),
  //       pw.Text("Address: ${state.proformaPdfDto.customerAddress}", style: style),
  //       pw.Text("TAX ID: ${state.proformaPdfDto.taxId}", style: style),
  //       pw.SizedBox(height: 8),
  //       pw.Divider(height: 0.5, color: tableBorderColor),
  //       pw.SizedBox(height: 8),
  //       pw.Text(
  //         "Proforma Date: ${state.proformaPdfDto.date.formattedDateDDMMYYYY}",
  //         style: pw.TextStyle(
  //           color: textColor,
  //           fontSize: 11,
  //           fontWeight: pw.FontWeight.bold,
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // pw.Widget buildMainTable(ProformaPdfResourcesLoaded state) {
  //   final headers = [
  //     'Description',
  //     'Container Number',
  //     'Weight (MT)',
  //     'Unit Price (EUR)',
  //     'Total Pirce (EUR)',
  //   ];

  //   final data = state.proformaPdfDto.descriptions
  //       .map((e) => [e.description, e.containerNumber, e.weight, e.unitPrice, e.totalPrice])
  //       .toList();

  //   return pw.TableHelper.fromTextArray(
  //     border: pw.TableBorder.all(
  //       color: tableBorderColor,
  //       width: 0.5,
  //     ),
  //     headerStyle: pw.TextStyle(
  //       fontWeight: pw.FontWeight.bold,
  //       color: PdfColors.black,
  //       fontSize: 10,
  //     ),
  //     headerDecoration: pw.BoxDecoration(
  //       color: tableHeaderColor,
  //     ),
  //     headerHeight: 25,
  //     cellStyle: const pw.TextStyle(
  //       fontSize: 10,
  //       lineSpacing: 1,
  //     ),
  //     cellHeight: 25,
  //     cellAlignments: {
  //       0: pw.Alignment.centerLeft,
  //       1: pw.Alignment.center,
  //       2: pw.Alignment.center,
  //       3: pw.Alignment.center,
  //       4: pw.Alignment.center,
  //     },
  //     headerAlignments: {
  //       0: pw.Alignment.centerLeft,
  //       1: pw.Alignment.center,
  //       2: pw.Alignment.center,
  //       3: pw.Alignment.center,
  //       4: pw.Alignment.center,
  //     },
  //     headers: headers,
  //     data: data,
  //   );
  // }

  // pw.Widget buildSummaryTable(ProformaPdfResourcesLoaded state) {
  //   final headers = [
  //     'Origin Of Goods',
  //     'Containers Count',
  //     'Total Weight (MT)',
  //     'Total Amount EUR',
  //   ];

  //   final data = [
  //     [
  //       'Spain',
  //       state.proformaPdfDto.descriptions.length.toString(),
  //       '${state.proformaPdfDto.totalWeight} MT',
  //       '${state.proformaPdfDto.totalAmount} EUR',
  //     ],
  //   ];

  //   return pw.TableHelper.fromTextArray(
  //     border: pw.TableBorder.all(
  //       color: tableBorderColor,
  //       width: 0.5,
  //     ),
  //     headerStyle: pw.TextStyle(
  //       fontWeight: pw.FontWeight.bold,
  //       color: PdfColors.black,
  //       fontSize: 10,
  //     ),
  //     headerDecoration: pw.BoxDecoration(
  //       color: tableHeaderColor,
  //     ),
  //     headerHeight: 25,
  //     cellStyle: const pw.TextStyle(
  //       fontSize: 10,
  //     ),
  //     cellHeight: 25,
  //     cellAlignments: {
  //       0: pw.Alignment.centerLeft,
  //       1: pw.Alignment.center,
  //       2: pw.Alignment.center,
  //       3: pw.Alignment.center,
  //     },
  //     headerAlignments: {
  //       0: pw.Alignment.centerLeft,
  //       1: pw.Alignment.center,
  //       2: pw.Alignment.center,
  //       3: pw.Alignment.center,
  //     },
  //     headers: headers,
  //     data: data,
  //   );
  // }

  // pw.Widget buildNotes(ProformaPdfResourcesLoaded state) {
  //   return pw.Column(
  //     crossAxisAlignment: pw.CrossAxisAlignment.start,
  //     children: [
  //       pw.Text(
  //         'Notes:',
  //         style: pw.TextStyle(
  //           color: textColor,
  //           fontSize: 11,
  //           fontWeight: pw.FontWeight.bold,
  //         ),
  //       ),
  //       pw.SizedBox(height: 5),
  //       pw.Text(
  //         state.proformaPdfDto.notes,
  //         style: const pw.TextStyle(fontSize: 9),
  //       ),
  //     ],
  //   );
  // }

  // pw.Widget buildFooter(ProformaPdfResourcesLoaded state) {
  //   return pw.Row(
  //     crossAxisAlignment: pw.CrossAxisAlignment.start,
  //     children: [
  //       pw.Expanded(
  //         child: pw.Column(
  //           crossAxisAlignment: pw.CrossAxisAlignment.start,
  //           children: [
  //             pw.Text(
  //               'Bank Details:',
  //               style: pw.TextStyle(
  //                 color: PdfColors.red,
  //                 fontSize: 11,
  //                 fontWeight: pw.FontWeight.bold,
  //               ),
  //             ),
  //             pw.SizedBox(height: 5),
  //             pw.Text('Bank Name: ${state.proformaPdfDto.bankName}', style: const pw.TextStyle(fontSize: 9)),
  //             pw.Text('IBAN EURO: ${state.proformaPdfDto.bankAccountNumber}', style: const pw.TextStyle(fontSize: 9)),
  //             pw.Text('SWIFT BIC: ${state.proformaPdfDto.swiftCode}', style: const pw.TextStyle(fontSize: 9)),
  //             pw.Text('Beneficiary: ${state.company.name}', style: const pw.TextStyle(fontSize: 9)),
  //           ],
  //         ),
  //       ),
  //       pw.SizedBox(width: 40),
  //       pw.Column(
  //         crossAxisAlignment: pw.CrossAxisAlignment.end,
  //         children: [
  //           pw.Text(
  //             'Seller Signature:',
  //             style: pw.TextStyle(
  //               color: PdfColors.blue900,
  //               fontSize: 11,
  //               fontWeight: pw.FontWeight.bold,
  //             ),
  //           ),
  //           pw.SizedBox(height: 10),
  //           pw.Image(state.signatureImageProvider, width: 150, height: 70, dpi: 3000),
  //         ],
  //       ),
  //     ],
  //   );
  // }
}
