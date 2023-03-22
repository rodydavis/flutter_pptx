import 'dart:typed_data';

import 'package:archive/archive.dart';

class Archive {
  ZipEncoder encoder = ZipEncoder();

  reset() {
    encoder = ZipEncoder();
  }

  saveStringFile(String path, String source) {
    final file = ArchiveFile.string(path, source);
    encoder.addFile(file);
  }

  saveBytesFile(String path, List<int> source) {
    final file = ArchiveFile(path, source.length, source);
    encoder.addFile(file);
  }
}
