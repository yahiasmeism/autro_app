import 'dart:io';
import 'package:autro_app/core/theme/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageViewer extends StatelessWidget {
  const ImageViewer({super.key, this.networkPath, this.localPath}) : assert(networkPath != null || localPath != null);

  final String? localPath;
  final String? networkPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: localPath != null
                ? Image.file(
                    File(localPath!),
                    fit: BoxFit.contain,
                  )
                : CachedNetworkImage(
                    imageUrl: networkPath!,
                    fit: BoxFit.contain,
                    progressIndicatorBuilder: (context, child, loadingProgress) {
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.progress,
                        ),
                      );
                    },
                    errorWidget: (context, error, stackTrace) {
                      return const Center(
                        child: Text(
                          'Failed to load image.',
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      );
                    },
                  ),
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
        ],
      ),
    );
  }
}
