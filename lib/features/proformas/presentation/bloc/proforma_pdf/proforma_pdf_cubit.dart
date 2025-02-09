import 'dart:io';

import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/proformas/domin/dtos/proforma_good_description_dto.dart';
import 'package:autro_app/features/settings/domin/entities/company_entity.dart';
import 'package:autro_app/features/settings/domin/use_cases/get_company_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../settings/domin/entities/invoice_settings_entity.dart';
import '../../../../settings/domin/use_cases/get_invoice_settings_use_case.dart';

part 'proforma_pdf_state.dart';

@injectable
class ProformaPdfCubit extends Cubit<ProformaPdfState> {
  ProformaPdfCubit(this.getCompanyUseCase, this.getInvoiceSettingsUseCase) : super(ProformaPdfInitial());

  final GetCompanyUseCase getCompanyUseCase;
  final GetInvoiceSettingsUseCase getInvoiceSettingsUseCase;
  init(ProformaPdfDto dto, {required PdfAction action, required String? saveFilePath}) async {
    emit(ProformaPdfResourcesLoading());
    await Future.delayed(const Duration(milliseconds: 300));

    final either = await getCompanyUseCase.call(NoParams());

    either.fold(
      (failure) => emit(ProformaPdfError(failure: failure)),
      (company) async {
        if (company.logoUrl.isEmpty) {
          emit(const ProformaPdfError(failure: GeneralFailure(message: 'Logo not found, please add logo')));

          return;
        }
        if (company.signatureUrl.isEmpty) {
          emit(const ProformaPdfError(failure: GeneralFailure(message: 'Signature not found, please add signature')));

          return;
        }
        final logoImageProvider = await networkImage(company.logoUrl, dpi: 3000, cache: true);
        final signatureImageProvider = await networkImage(company.signatureUrl, dpi: 3000, cache: true);

        final invoiceSettingsEither = await getInvoiceSettingsUseCase.call(NoParams());

        invoiceSettingsEither.fold(
          (l) => emit(ProformaPdfError(failure: l)),
          (invoiceSettings) {
            emit(
              ProformaPdfResourcesLoaded(
                invoiceSettings: invoiceSettings,
                company: company,
                logoImageProvider: logoImageProvider,
                signatureImageProvider: signatureImageProvider,
                proformaPdfDto: dto,
                action: action,
                filePath: saveFilePath,
              ),
            );
          },
        );
      },
    );
  }

  Future<void> exportProformaPdf(String saveFilePath, pw.Page page) async {
    emit(ExportProformaLoading());

    try {
      final pdf = pw.Document();
      pdf.addPage(page);

      final file = File(saveFilePath);
      await file.writeAsBytes(await pdf.save());
      emit(ExportProformaDone(filePath: saveFilePath));
    } catch (e) {
      emit(const ProformaPdfError(failure: GeneralFailure(message: 'Error generating PDF')));
    }
  }

  Future<void> generateProformaPdf(pw.Page page) async {
    emit(ProformaPdfGenerating());
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      final pdf = pw.Document();
      pdf.addPage(page);

      final output = await getTemporaryDirectory();
      final file = File("${output.path}/proforma.pdf");

      await file.writeAsBytes(await pdf.save());

      emit(ProformaPdfGenerated(pdfPath: file.path));
    } catch (_) {
      emit(const ProformaPdfError(failure: GeneralFailure(message: 'Error generating PDF')));
    }
  }
}
