import 'dart:io';

import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewer extends StatelessWidget {
  const PdfViewer({super.key, this.networkPath, this.localPath}) : assert(networkPath != null || localPath != null);

  final String? localPath;
  final String? networkPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      localPath != null
          ? SfPdfViewer.file(
              File(localPath!),
              enableDoubleTapZooming: true,
              canShowPaginationDialog: true,
              canShowPageLoadingIndicator: true,
              initialZoomLevel: 0.5,
              interactionMode: PdfInteractionMode.pan,
              onDocumentLoadFailed: (details) {
                DialogUtil.showErrorSnackBar(context, 'Failed to load PDF.');
              },
            )
          : FutureBuilder<bool>(
              future: _validateUrl(networkPath!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError || !(snapshot.data ?? false)) {
                  return const Center(
                    child: Text(
                      'Invalid or Unreachable PDF URL.',
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                  );
                } else {
                  return SfPdfViewer.network(
                    interactionMode: PdfInteractionMode.pan,
                    networkPath!,
                    enableDoubleTapZooming: true,
                    canShowPaginationDialog: true,
                    canShowPageLoadingIndicator: true,
                    initialZoomLevel: 0.5,
                    onDocumentLoadFailed: (details) {
                      DialogUtil.showErrorSnackBar(context, 'Failed to load PDF.');
                    },
                  );
                }
              },
            ),

      // Back button
      Positioned(
        top: 24,
        left: 24,
        child: IconButton(
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: AppColors.secondaryOpacity13),
            ),
            backgroundColor: AppColors.scaffoldBackgroundColor,
          ),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    ]));
  }

  Future<bool> _validateUrl(String url) async {
    try {
      final uri = Uri.tryParse(url);
      if (uri == null || !(uri.hasScheme && uri.hasAuthority)) {
        return false;
      }
      final response = Uri.base.resolve(url).toString().startsWith('http');
      return response;
    } catch (e) {
      return false;
    }
  }
}
