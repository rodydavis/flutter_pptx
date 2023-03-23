import 'dart:convert';
import 'dart:io';

import 'package:archive/archive_io.dart';

void main() {
  // final decoder = ZipDecoder();
  // final file = File('./build/sample.pptx');
  // final bytes = file.readAsBytesSync();
  // final archive = decoder.decodeBytes(bytes);
  // final files = archive.files.toList();
  // for (final entry in files) {
  //   print(entry.name);
  // }
  // final newFile = File('./build/sample2.pptx');
  // final encoder = ZipEncoder();
  // final newArchive = Archive();
  // for (final file in files) {
  //   newArchive.addFile(file);
  // }
  // final newBytes = encoder.encode(
  //   newArchive,
  //   level: Deflate.NO_COMPRESSION,
  // );
  // if (newBytes != null) newFile.writeAsBytesSync(newBytes);
  final encoder = ZipFileEncoder();
  encoder.zipDirectory(
    Directory('./build/pptx'),
    filename: './build/test.pptx',
  );
}
