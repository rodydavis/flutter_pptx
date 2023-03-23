import 'dart:io';

import 'package:archive/archive_io.dart';

List<int>? createZip(Map<String, dynamic> files) {
  final encoder = ZipFileEncoder();
  final tempDir = Directory.systemTemp.createTempSync();
  for (final entry in files.entries) {
    final name = entry.key;
    final value = entry.value;
    if (value is List<int>) {
      final file = File('${tempDir.path}/$name');
      if (!file.existsSync()) {
        file.createSync(recursive: true);
      }
      file.writeAsBytesSync(value);
    } else if (value is String) {
      final file = File('${tempDir.path}/$name');
      if (!file.existsSync()) {
        file.createSync(recursive: true);
      }
      file.writeAsStringSync(value);
    }
  }
  final outFile = File('${tempDir.path}/presentation.pptx');
  encoder.zipDirectory(
    tempDir,
    filename: outFile.path,
  );
  final bytes = outFile.readAsBytesSync();
  tempDir.deleteSync(recursive: true);
  return bytes;
}
