import 'package:archive/archive.dart';

import 'archive/create_zip.dart';

class Compression {
  final archive = Archive();
  final files = <String, dynamic>{};

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

  List<int>? toBytes() => createZip(files);
}
