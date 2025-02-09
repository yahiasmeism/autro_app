import 'dart:io';

import 'package:file_picker/file_picker.dart';

class FileUtils {
  FileUtils._();
  static Future<String?> pickSaveLocation(String fileName, String extension) async {
    String? filePath = await FilePicker.platform.saveFile(
      dialogTitle: 'Select a location to save your file',
      fileName: '$fileName.$extension',
    );

    return filePath;
  }

  static void openFolder(String filePath) {
    if (Platform.isWindows) {
      Process.run('explorer', ['/select,', filePath]);
    } else if (Platform.isMacOS) {
      Process.run('open', ['-R', filePath]);
    } else if (Platform.isLinux) {
      Process.run('xdg-open', [filePath]);
    }
  }
}
