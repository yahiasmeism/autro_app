import 'dart:io';

import 'package:autro_app/core/extensions/file_extension.dart';
import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:autro_app/core/utils/nav_util.dart';
import 'package:autro_app/core/widgets/image_viewer.dart';
import 'package:autro_app/core/widgets/app_pdf_viewer.dart';
import 'package:autro_app/features/deals/presentation/bloc/deal_bill_form/deal_bill_form_bloc.dart';
import 'package:autro_app/features/settings/presentation/widgets/upload_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DealBillAttachmentUploader extends StatelessWidget {
  const DealBillAttachmentUploader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DealBillFormBloc, DealBillFormState>(
      builder: (context, state) {
        if (state is DealBillFormLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Attachment',
                style: TextStyles.font16Regular,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildAttachmentBox(state, context),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UploadButton(
                        onTap: () async => await _pickAttachment(context),
                        title: 'Upload Attachment',
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'PDF, JPEG, PNG, JPG, Max 4MB',
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


  Widget _buildAttachmentBox(DealBillFormLoaded state, BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border: Border.all(color: AppColors.secondaryOpacity13),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: state.pickedAttachment.fold(
                () {
                  return state.attachmentUrl.fold(
                    () => _buildPlaceholder(),
                    (url) {
                      if (state.dealBillHasImageAttachment) {
                        return _buildCachedNetworkImage(url, context);
                      } else if (state.dealBillHasPdfAttachment) {
                        return _buildNetworkPdf(url, context);
                      }
                      return _buildPlaceholder();
                    },
                  );
                },
                (file) {
                  if (file.isImage) {
                    return InkWell(
                      onTap: () => NavUtil.push(context, ImageViewer(localPath: file.path)),
                      child: Image.file(file),
                    );
                  } else if (file.isPdf) {
                    return _buildLocalPdf(file, context);
                  }

                  return _buildPlaceholder();
                },
              ),
            )),
        if (state.pickedAttachment.isSome() || state.attachmentUrl.isSome())
          Positioned(
            top: -8,
            right: -8,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => context.read<DealBillFormBloc>().add(ClearAttachmentEvent()),
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.secondaryOpacity13,
                ),
                child: const Icon(
                  Icons.close,
                  color: AppColors.secondary,
                  size: 16,
                ),
              ),
            ),
          )
      ],
    );
  }

  Widget _buildPlaceholder() {
    return Center(
      child: Text(
        'File',
        style: TextStyles.font20Regular.copyWith(color: AppColors.hintColor),
      ),
    );
  }

  Future<void> _pickAttachment(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      type: FileType.custom,
      onFileLoading: (p0) {},
      allowMultiple: false,
    );

    if (result != null && result.files.single.path != null) {
      final pickedFile = File(result.files.single.path!);
      final fileSizeInBytes = pickedFile.lengthSync();
      final fileSizeInMB = fileSizeInBytes / (1024 * 1024);

      if (!context.mounted) return;

      if (fileSizeInMB > 4) {
        DialogUtil.showErrorSnackBar(context, 'File size exceeds 4 MB. Please choose a smaller file.');
        return;
      }
      context.read<DealBillFormBloc>().add(PickAttachmentEvent(file: pickedFile));
    }
  }

  Widget _buildCachedNetworkImage(String url, BuildContext context) {
    return InkWell(
      onTap: () {
        NavUtil.push(context, ImageViewer(networkPath: url));
      },
      child: CachedNetworkImage(
        errorWidget: (context, url, error) {
          return const Center(
              child: Icon(
            Icons.error_outline,
            color: AppColors.red,
            size: 40,
          ));
        },
        imageUrl: url,
        progressIndicatorBuilder: (context, url, progress) {
          return Center(child: CircularProgressIndicator(value: progress.progress));
        },
      ),
    );
  }

  Widget _buildLocalPdf(File file, BuildContext context) {
    return InkWell(
      onTap: () {
        NavUtil.push(context, AppPdfViewer(localPath: file.path));
      },
      child: const Icon(
        color: AppColors.primary,
        Icons.picture_as_pdf,
        size: 40,
      ),
    );
  }

  Widget _buildNetworkPdf(String attachmentUrl, BuildContext context) {
    return InkWell(
      onTap: () {
        NavUtil.push(context, AppPdfViewer(networkPath: attachmentUrl));
      },
      child: const Icon(
        Icons.picture_as_pdf,
        size: 40,
      ),
    );
  }
}
