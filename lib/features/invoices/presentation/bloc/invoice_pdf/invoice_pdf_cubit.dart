import 'dart:io';

import 'package:autro_app/core/errors/failures.dart';
import 'package:autro_app/core/interfaces/use_case.dart';
import 'package:autro_app/features/settings/domin/use_cases/get_company_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../domin/dtos/invoice_pdf_dto.dart';
part 'invoice_pdf_state.dart';

@injectable
class InvoicePdfCubit extends Cubit<InvoicePdfState> {
  InvoicePdfCubit(this.getCompanyUseCase) : super(InvoicePdfInitial());

  final GetCompanyUseCase getCompanyUseCase;

  init(InvoicePdfDto dto) async {
    final either = await getCompanyUseCase.call(NoParams());

    either.fold(
      (failure) => emit(InvoicePdfError(failure: failure)),
      (company) async {
        if (company.logoUrl.isEmpty) {
          emit(const InvoicePdfError(failure: GeneralFailure(message: 'Logo not found, please add logo')));

          return;
        }
        if (company.signatureUrl.isEmpty) {
          emit(const InvoicePdfError(failure: GeneralFailure(message: 'Signature not found, please add signature')));

          return;
        }
        final logoImageProvider = await networkImage(company.logoUrl, dpi: 3000, cache: true);
        final signatureImageProvider = await networkImage(company.signatureUrl, dpi: 3000, cache: true);
        emit(InvoicePdfResourcesLoaded(logoImageProvider: logoImageProvider, signatureImageProvider: signatureImageProvider));
      },
    );
  }

  Future<void> generateInvoicePdf(pw.Page page) async {
    try {
      final pdf = pw.Document();
      pdf.addPage(page);

      final output = await getTemporaryDirectory();
      final file = File("${output.path}/invoice.pdf");

      await file.writeAsBytes(await pdf.save());

      emit(InvoicePdfGenerated(pdfPath: file.path));
    } catch (_) {
      emit(const InvoicePdfError(failure: GeneralFailure(message: 'Error generating PDF')));
    }
  }
}
