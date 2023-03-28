import 'zip_file_encoder.dart';

List<int>? createZip(Map<String, dynamic> files) {
  final encoder = ZipFileEncoder();
  final tempDir = fs.systemTempDirectory.createTempSync();
  for (final entry in files.entries) {
    final name = entry.key;
    final value = entry.value;
    if (value is List<int>) {
      final file = fs.file('${tempDir.path}/$name');
      if (!file.existsSync()) {
        file.createSync(recursive: true);
      }
      file.writeAsBytesSync(value);
    } else if (value is String) {
      final file = fs.file('${tempDir.path}/$name');
      if (!file.existsSync()) {
        file.createSync(recursive: true);
      }
      file.writeAsStringSync(value);
    }
  }
  final outFile = fs.file('${tempDir.path}/presentation.pptx');
  encoder.zipDirectory(
    tempDir,
    filename: outFile.path,
  );
  final bytes = outFile.readAsBytesSync();
  tempDir.deleteSync(recursive: true);
  return bytes;
}
