// import 'dart:io';

// import 'package:autro_app/core/theme/app_colors.dart';
// import 'package:autro_app/core/utils/dialog_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// class AppPdfViewer extends StatelessWidget {
//   const AppPdfViewer({super.key, this.networkPath, this.localPath}) : assert(networkPath != null || localPath != null);

//   final String? localPath;
//   final String? networkPath;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Stack(children: [
//       localPath != null
//           ? SfPdfViewer.file(
//               File(localPath!),
//               enableDoubleTapZooming: true,
//               canShowPaginationDialog: true,
//               canShowPageLoadingIndicator: true,
//               initialZoomLevel: 0.5,
//               interactionMode: PdfInteractionMode.pan,
//               onDocumentLoadFailed: (details) {
//                 DialogUtil.showErrorSnackBar(context, 'Failed to load PDF.');
//               },
//             )
//           : FutureBuilder<bool>(
//               future: _validateUrl(networkPath!),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError || !(snapshot.data ?? false)) {
//                   return const Center(
//                     child: Text(
//                       'Invalid or Unreachable PDF URL.',
//                       style: TextStyle(fontSize: 16, color: Colors.red),
//                     ),
//                   );
//                 } else {
//                   return SfPdfViewer.network(
//                     interactionMode: PdfInteractionMode.pan,
//                     networkPath!,
//                     enableDoubleTapZooming: true,
//                     canShowPaginationDialog: true,
//                     canShowPageLoadingIndicator: true,
//                     initialZoomLevel: 0.5,
//                     onDocumentLoadFailed: (details) {
//                       DialogUtil.showErrorSnackBar(context, 'Failed to load PDF.');
//                     },
//                   );
//                 }
//               },
//             ),

//       // Back button
//       Positioned(
//         top: 24,
//         left: 24,
//         child: IconButton(
//           style: IconButton.styleFrom(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8),
//               side: BorderSide(color: AppColors.secondaryOpacity13),
//             ),
//             backgroundColor: AppColors.scaffoldBackgroundColor,
//           ),
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//     ]));
//   }

//   Future<bool> _validateUrl(String url) async {
//     try {
//       final uri = Uri.tryParse(url);
//       if (uri == null || !(uri.hasScheme && uri.hasAuthority)) {
//         return false;
//       }
//       final response = Uri.base.resolve(url).toString().startsWith('http');
//       return response;
//     } catch (e) {
//       return false;
//     }
//   }
// }

import 'package:autro_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';

class AppPdfViewer extends StatelessWidget {
  const AppPdfViewer({super.key, this.localPath, this.networkPath});
  final String? localPath;
  final String? networkPath;

  @override
  Widget build(BuildContext context) {
    final controller = PdfViewerController();
    late Widget pdfViewer;

    final params = PdfViewerParams(
      panEnabled: true,
      // enableTextSelection: true,
      scaleEnabled: true,
      scrollByMouseWheel: 1,
      panAxis: PanAxis.free,
      errorBannerBuilder: (context, error, stackTrace, documentRef) {
        return Center(child: Text(error.toString()));
      },
      viewerOverlayBuilder: (context, size, handleLinkTap) => [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onDoubleTap: () {
            controller.zoomUp(loop: true);
          },
          onTapUp: (details) {
            handleLinkTap(details.localPosition);
          },
          child: IgnorePointer(
            child: SizedBox(width: size.width, height: size.height),
          ),
        ),
      ],
      loadingBannerBuilder: (context, bytesDownloaded, totalBytes) {
        return Center(
          child: CircularProgressIndicator(
            value: totalBytes != null ? bytesDownloaded / totalBytes : null,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
            strokeWidth: 8,
            strokeAlign: 8,
          ),
        );
      },
    );

    if (localPath != null) {
      pdfViewer = PdfViewer.file(
        controller: controller,
        localPath!,
        params: params,
        firstAttemptByEmptyPassword: true,
      );
    } else {
      final uri = Uri.parse(networkPath!);
      pdfViewer = PdfViewer.uri(
        controller: controller,
        uri,
        params: params,
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          pdfViewer,

          // Back button
          Positioned(
            top: 24,
            left: 24,
            child: IconButton(
              style: IconButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Colors.grey.shade300),
                ),
                backgroundColor: Colors.white,
              ),
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // Zoom In button
          Positioned(
            bottom: 100,
            right: 16,
            child: ElevatedButton(
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.all(16),
                backgroundColor: AppColors.primary,
                shape: CircleBorder(side: BorderSide(color: Colors.grey.shade300)),
              ),
              onPressed: () => controller.zoomUp(),
              child: const Icon(Icons.zoom_in, color: Colors.white),
            ),
          ),

          // Zoom Out button
          Positioned(
              bottom: 48,
              right: 16,
              child: ElevatedButton(
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  backgroundColor: AppColors.primary,
                  shape: CircleBorder(side: BorderSide(color: Colors.grey.shade300)),
                ),
                onPressed: () => controller.zoomDown(),
                child: const Icon(Icons.zoom_out, color: Colors.white),
              ))
        ],
      ),
    );
  }
}
