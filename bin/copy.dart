import 'dart:convert';
import 'dart:io';

import 'package:recase/recase.dart';
import 'package:path/path.dart' as path;

final inputDir = Directory('./template');
final outputDir = Directory('./packages/dart_pptx/lib/src/template');

void main() {
  if (!outputDir.existsSync()) {
    outputDir.createSync(recursive: true);
  } else {
    outputDir.deleteSync(recursive: true);
    outputDir.createSync(recursive: true);
  }

  final files = inputDir.listSync(recursive: true);
  for (final file in files) {
    if (file is File) {
      // outputFile.writeAsStringSync(file.readAsStringSync());
      final sb = StringBuffer();
      sb.writeln('/// This file is generated, do not edit!');
      sb.writeln('/// See `bin/copy.dart` for more information.');
      sb.writeln();
      sb.writeln('/// Path: ${file.path}');
      // Fix for encoding: UTF-16
      // sb.write('const List<int> template = [');
      //  // final bytes = content.buffer.asUint16List();
      // for (final byte in bytes) {
      //   sb.write(' $byte,');
      // }
      // sb.writeln('];');
      sb.write('const String template = r\'\'\'');
      if (file.path.endsWith('.png')) {
        // Base 64 string
        final bytes = file.readAsBytesSync();
        final base64 = base64Encode(bytes);
        sb.write(base64);
      } else {
        final content = file.readAsStringSync();
        sb.write(content.trim());
      }
      sb.writeln('\'\'\';');
      sb.writeln();

      String relativePath = file.path.substring(inputDir.path.length);
      relativePath = '$relativePath.dart';

      // Check for . files
      final filename = path.basename(file.path);
      if (filename.startsWith('.')) {
        // Replace . with _
        relativePath = relativePath.replaceAll(filename, '_$filename');
      }
      final outputFile = File(outputDir.path + relativePath);
      outputFile.createSync(recursive: true);
      outputFile.writeAsStringSync(sb.toString().trim());
    }
  }

  // Create index file
  final sb = StringBuffer();
  sb.writeln('/// This file is generated, do not edit!');
  sb.writeln('/// See `bin/copy.dart` for more information.');
  sb.writeln();
  for (final file in files) {
    if (file is File) {
      String relativePath = file.path.substring(inputDir.path.length);
      relativePath = '$relativePath.dart';
      final filename = relativePath.split('.').first;
      String name = filename.snakeCase;
      if (relativePath.contains('/.')) {
        relativePath = relativePath.replaceAll('/.', '/_.');
      }
      name = alias(name);
      sb.writeln('import \'${relativePath.substring(1)}\' as $name;');
    }
  }
  sb.writeln();
  sb.writeln('final templates = {');
  for (final file in files) {
    if (file is File) {
      String relativePath = file.path.substring(inputDir.path.length);
      relativePath = '$relativePath.dart';
      String filename = relativePath.split('.').first;
      final orgFilename = relativePath.substring(1).replaceAll('.dart', '');
      String name = filename.snakeCase;
      name = alias(name);
      sb.writeln('  \'$orgFilename\': $name.template,');
    }
  }
  sb.writeln('};');
  sb.writeln();

  final outputFile = File('${outputDir.path}/template.dart');
  outputFile.createSync(recursive: true);
  outputFile.writeAsStringSync(sb.toString());
}

String alias(String value) {
  String name = value;
  name = name.replaceAll('[', '');
  name = name.replaceAll(']', '');
  if (name.startsWith('_')) {
    name = name.substring(1);
  }
  return name;
}
