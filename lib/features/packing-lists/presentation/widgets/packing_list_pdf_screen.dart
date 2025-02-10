import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/di/di.dart';
import 'package:autro_app/core/extensions/date_time_extension.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/utils/file_utils.dart';
import 'package:autro_app/core/utils/nav_util.dart';
import 'package:autro_app/core/widgets/app_pdf_viewer.dart';
import 'package:autro_app/core/widgets/failure_screen.dart';
import 'package:autro_app/core/widgets/loading_indecator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../core/theme/text_styles.dart';
import '../bloc/packing_list_form/packing_list_form_cubit.dart';
import '../bloc/packing_list_pdf/packing_list_pdf_cubit.dart';

class PackingListPdfScreen extends StatelessWidget {
  const PackingListPdfScreen._();

  static create(BuildContext context, PackingListPdfDto dto, {PdfAction action = PdfAction.view, String? filePath}) {
    NavUtil.push(
      context,
      BlocProvider<PackingListPdfCubit>(
        create: (context) => sl<PackingListPdfCubit>()..init(dto, action: action, saveFilePath: filePath),
        child: const PackingListPdfScreen._(),
      ),
    );
  }

  PdfColor get textColor => const PdfColor.fromInt(0xff083156);
  PdfColor get tableHeaderColor => PdfColors.grey100;
  PdfColor get tableBorderColor => PdfColors.grey400;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PackingListPdfCubit, PackingListPdfState>(
      listener: listener,
      builder: (context, state) {
        if (state is PackingListPdfInitial) {
          return const LoadingIndicator();
        } else if (state is PackingListPdfResourcesLoading) {
          return const LoadingIndicator(loadingMessage: 'Preparing resoures...');
        } else if (state is PackingListPdfGenerating) {
          return const LoadingIndicator(loadingMessage: 'Generating...');
        } else if (state is PackingListPdfGenerated) {
          return AppPdfViewer(localPath: state.pdfPath);
        } else if (state is ExportPackingListLoading) {
          return const LoadingIndicator(loadingMessage: 'Exporting..');
        } else if (state is PackingListPdfError) {
          return Center(child: Scaffold(appBar: AppBar(), body: FailureScreen(failure: state.failure)));
        }
        return const SizedBox.shrink();
      },
    );
  }

  void listener(BuildContext context, PackingListPdfState state) {
    if (state is PackingListPdfResourcesLoaded) {
      final packingListContent = _buildPackingListPdfContent(state);
      if (state.action == PdfAction.view) {
        context.read<PackingListPdfCubit>().generatePackingListPdf(packingListContent);
      } else if (state.action == PdfAction.export) {
        context.read<PackingListPdfCubit>().exportPackingListPdf(state.filePath!, packingListContent);
      }
    }
    if (state is ExportPackingListDone) {
      DialogUtil.showSuccessSnackBar(
          context,
          'PackingList saved successfully as: ${state.filePath.split('/').last}',
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

  pw.Page _buildPackingListPdfContent(PackingListPdfResourcesLoaded state) {
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
            pw.SizedBox(height: 12),
            buildMainTable(state),
            buildSummaryTable(state),
            pw.SizedBox(height: 12),
            pw.Spacer(),
            buildFooter(state),
            // pw.SizedBox(height: 20),
          ],
        );
      },
    );
  }

  pw.Widget buildHeader(PackingListPdfResourcesLoaded state) {
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
          'Packing List',
          style: pw.TextStyle(
            fontSize: 24,
            color: textColor,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      ],
    );
  }

  pw.Widget buildCompanyInfo(PackingListPdfResourcesLoaded state) {
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
        pw.Text("To: ${state.packingListPdfDto.customerName}", style: style),
        pw.SizedBox(height: 2),
        pw.Text("Address: ${state.packingListPdfDto.customerAddress}", style: style),
        pw.SizedBox(height: 2),
        pw.Text("TAX ID: ${state.packingListPdfDto.taxId}", style: style),
        pw.SizedBox(height: 8),
        pw.Divider(height: 0.5, color: tableBorderColor),
        pw.SizedBox(height: 8),
      ],
    );
  }

  pw.Widget buildMainTable(PackingListPdfResourcesLoaded state) {
    final headers = [
      'CONTAINER',
      'PERCENTO',
      'PACKING TYPE',
      'ITEMS COUNT',
      'WEIGHT',
      'EMPTY CONTAINER WEIGHT',
      'VGM',
      'DATE',
    ];

    final data = state.packingListPdfDto.descriptions
        .map((e) => [
              e.containerNumber,
              e.percento,
              e.type,
              e.itemsCount,
              e.weight,
              e.emptyContainerWeight,
              e.vgm.toStringAsFixed(2),
              e.date.formattedDateDDMMYYYY
            ])
        .toList();

    return pw.TableHelper.fromTextArray(
      border: pw.TableBorder.all(
        color: tableBorderColor,
        width: 0.5,
      ),
      headerStyle: pw.TextStyle(
        fontWeight: pw.FontWeight.bold,
        color: textColor,
        fontSize: 8,
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

  pw.Widget buildSummaryTable(PackingListPdfResourcesLoaded state) {
    final headers = [
      'Total Count',
      'Total Weight (MT)',
    ];

    final data = [
      [
        '${state.packingListPdfDto.totalCount}',
        '${state.packingListPdfDto.allWeight} MT',
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

  pw.Widget buildFooter(PackingListPdfResourcesLoaded state) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Spacer(),
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
