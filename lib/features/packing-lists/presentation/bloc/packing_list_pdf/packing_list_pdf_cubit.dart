import 'dart:io';

import 'package:autro_app/core/constants/enums.dart';
import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/packing-lists/presentation/bloc/packing_list_form/packing_list_form_cubit.dart';
import 'package:autro_app/features/settings/domin/entities/company_entity.dart';
import 'package:autro_app/features/settings/domin/use_cases/get_company_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

part 'packing_list_pdf_state.dart';

@injectable
class PackingListPdfCubit extends Cubit<PackingListPdfState> {
  PackingListPdfCubit(this.getCompanyUseCase) : super(PackingListPdfInitial());

  final GetCompanyUseCase getCompanyUseCase;

  init(PackingListPdfDto dto, {required PdfAction action, required String? saveFilePath}) async {
    emit(PackingListPdfResourcesLoading());
    await Future.delayed(const Duration(milliseconds: 300));

    final either = await getCompanyUseCase.call(NoParams());

    either.fold(
      (failure) => emit(PackingListPdfError(failure: failure)),
      (company) async {
        if (company.logoUrl.isEmpty) {
          emit(const PackingListPdfError(failure: GeneralFailure(message: 'Logo not found, please add logo')));

          return;
        }
        if (company.signatureUrl.isEmpty) {
          emit(const PackingListPdfError(failure: GeneralFailure(message: 'Signature not found, please add signature')));

          return;
        }
        final logoImageProvider = await networkImage(company.logoUrl, dpi: 3000, cache: true);
        final signatureImageProvider = await networkImage(company.signatureUrl, dpi: 3000, cache: true);
        emit(PackingListPdfResourcesLoaded(
          company: company,
          logoImageProvider: logoImageProvider,
          signatureImageProvider: signatureImageProvider,
          packingListPdfDto: dto,
          action: action,
          filePath: saveFilePath,
        ));
      },
    );
  }

  Future<void> exportPackingListPdf(String saveFilePath, pw.Page page) async {
    emit(ExportPackingListLoading());

    try {
      final pdf = pw.Document();
      pdf.addPage(page);

      final file = File(saveFilePath);
      await file.writeAsBytes(await pdf.save());
      emit(ExportPackingListDone(filePath: saveFilePath));
    } catch (e) {
      emit(const PackingListPdfError(failure: GeneralFailure(message: 'Error generating PDF')));
    }
  }

  Future<void> generatePackingListPdf(pw.Page page) async {
    emit(PackingListPdfGenerating());
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      final pdf = pw.Document();
      pdf.addPage(page);

      final output = await getTemporaryDirectory();
      final file = File("${output.path}/packingList.pdf");

      await file.writeAsBytes(await pdf.save());

      emit(PackingListPdfGenerated(pdfPath: file.path));
    } catch (_) {
      emit(const PackingListPdfError(failure: GeneralFailure(message: 'Error generating PDF')));
    }
  }
}
