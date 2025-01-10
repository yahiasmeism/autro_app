import 'dart:io';

import 'package:autro_app/core/extensions/dartz_option_extension.dart';
import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/features/settings/presentation/widgets/upload_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/company/company_cubit.dart';

class CompanySignatureUploader extends StatelessWidget {
  const CompanySignatureUploader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyCubit, CompanyState>(
      builder: (context, state) {
        if (state is CompanyLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Company Signature',
                style: TextStyles.font16Regular,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildImage(state),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UploadButton(
                        onTap: () async => await _pickSignatureFile(context),
                        title: 'Upload Signature',
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Recommended: 400x400px, Max 2MB',
                        style: TextStyles.font16Regular.copyWith(color: AppColors.secondaryOpacity75),
                      ),
                    ],
                  )
                ],
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildImage(CompanyLoaded state) {
    return Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: AppColors.secondaryOpacity13),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: state.pickedSignatureFile.isSome()
              ? Image.file(state.pickedSignatureFile.getSome())
              : state.company.signatureUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: state.company.signatureUrl,
                      progressIndicatorBuilder: (context, url, progress) {
                        return Center(child: CircularProgressIndicator(value: progress.progress));
                      },
                    )
                  : Center(
                      child: Text(
                        'Signature',
                        style: TextStyles.font20Regular.copyWith(color: AppColors.hintColor),
                      ),
                    ),
        ));
  }

  Future<void> _pickSignatureFile(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null && result.files.single.path != null) {
      final pickedFile = File(result.files.single.path!);
      final fileSizeInBytes = pickedFile.lengthSync();
      final fileSizeInMB = fileSizeInBytes / (1024 * 1024);

      if (!context.mounted) return;

      if (fileSizeInMB > 2) {
        DialogUtil.showErrorSnackBar(context, 'File size exceeds 2 MB. Please choose a smaller file.');
        return;
      }
      context.read<CompanyCubit>().pickSignatureFile(pickedFile);
    }
  }
}
