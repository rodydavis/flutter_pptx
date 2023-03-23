import 'package:archive/archive.dart';

class Compression {
  final archive = Archive();
  final files = <String, dynamic>{};

  void _addFiles() {
    for (final entry in files.entries) {
      final name = entry.key;
      final value = entry.value;

      // Skip if path contains .., ., or DS_Store
      if (name == '..' || name == '.' || name.contains('DS_Store')) {
        continue;
      }

      if (value is String) {
        String result = value;
        final lines = result.split('\n');
        result = lines.where((line) => line.trim().isNotEmpty).join('\n');
        result = result.trim();
        while (result.endsWith('\n')) {
          result = result.substring(0, result.length - 1);
        }
        final file = ArchiveFile.string(name, result);
        archive.addFile(file);
      } else if (value is List<int>) {
        final file = ArchiveFile(name, value.length, value);
        archive.addFile(file);
      }
    }
  }

  void addFile(String path, String source) {
    files[path] = source;
  }

  void addBinaryFile(String path, List<int> source) {
    files[path] = source;
  }

  void removeWhere(bool Function(String path, dynamic source) test) {
    files.removeWhere(test);
  }

  void removeFile(String path) {
    files.remove(path);
  }

  List<int>? toBytes() {
    _addFiles();
    return ZipEncoder().encode(archive);
  }
}
