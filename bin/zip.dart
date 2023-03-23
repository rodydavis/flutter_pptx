import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';

void main() {
  final decoder = ZipDecoder();
  final file = File('./build/sample.pptx');
  final bytes = file.readAsBytesSync();
  final archive = decoder.decodeBytes(bytes);
  for (final entry in archive.files) {
    print(entry.name);
  }
  final newFile = File('./build/sample2.pptx');
  final encoder = ZipEncoder(
    filenameEncoding: const Utf8Codec(),
  );
  final newBytes = encoder.encode(
    archive,
    level: Deflate.NO_COMPRESSION,
  );
  if (newBytes != null) newFile.writeAsBytesSync(newBytes);
}
