import 'package:archive/archive.dart';

List<int>? createZip(Map<String, dynamic> files) {
  final encoder = ZipEncoder();
  final archive = Archive();
  for (final entry in files.entries) {
    final name = entry.key;
    final value = entry.value;
    if (value is List<int>) {
      final file = ArchiveFile(name, value.length, value);
      archive.addFile(file);
    } else if (value is String) {
      String result = value;
      final lines = result.split('\n');
      result = lines.where((line) => line.trim().isNotEmpty).join('\n');
      result = result.trim();
      while (result.endsWith('\n')) {
        result = result.substring(0, result.length - 1);
      }
      final file = ArchiveFile.string(name, result);
      archive.addFile(file);
    }
  }
  return encoder.encode(archive);
}
