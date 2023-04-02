import 'dart:io';

import 'package:archive/archive.dart';

Future<Map<String, List<int>>> checkPptx(String path) async {
  final result = <String, List<int>>{};
  final file = File(path);
  final decoder = ZipDecoder();
  final bytes = file.readAsBytesSync();
  final archive = decoder.decodeBytes(bytes);
  final files = archive.files.toList();
  for (final entry in files) {
    if (entry.isFile) {
      if (entry.isFile) {
        final bytes = entry.content as List<int>;
        result[entry.name] = bytes;
      }
    }
  }
  return result;
}
