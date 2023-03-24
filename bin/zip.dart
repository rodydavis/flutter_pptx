import 'dart:io';

import 'package:archive/archive_io.dart';

void main() {
  final decoder = ZipDecoder();
  // final file = File('./samples/pptx/sample_notes.pptx');
  const name = 'classic_white_filled_img';
  final file = File('/Users/rodydavis/Desktop/templates/$name.pptx');
  final bytes = file.readAsBytesSync();
  final archive = decoder.decodeBytes(bytes);
  final files = archive.files.toList();
  final outputDir = Directory('./build/$name');
  for (final entry in files) {
    print(entry.name);
    if (entry.isFile) {
      if (entry.isFile) {
        // print(entry.content);
        final bytes = entry.content as List<int>;
        final outFile = File('${outputDir.path}/${entry.name}');
        if (!outFile.existsSync()) {
          outFile.createSync(recursive: true);
        }
        outFile.writeAsBytesSync(bytes);
      }
    }
  }
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
  // final encoder = ZipFileEncoder();
  // encoder.zipDirectory(
  //   Directory('./build/pptx'),
  //   filename: './build/test.pptx',
  // );
}
