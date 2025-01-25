import 'dart:io';

extension FileX on File {
  // check extension
  bool get isImage => path.split('.').last == 'jpg' || path.split('.').last == 'png' || path.split('.').last == 'jpeg';
  bool get isPdf => path.split('.').last == 'pdf';
}
