import 'dart:io';

import 'package:recase/recase.dart';

final inputDir = Directory('./template');
final outputDir = Directory('./lib/template');

void main() {
  if (!outputDir.existsSync()) {
    outputDir.createSync(recursive: true);
  }

  final files = inputDir.listSync(recursive: true);
  for (final file in files) {
    if (file is File) {
      // outputFile.writeAsStringSync(file.readAsStringSync());
      final content = file.readAsStringSync();
      final sb = StringBuffer();
      sb.writeln('/// This file is generated, do not edit!');
      sb.writeln('/// See `bin/copy.dart` for more information.');
      sb.writeln();
      sb.writeln('/// Path: ${file.path}');
      sb.writeln('const template = r\'\'\'');
      sb.writeln(content);
      sb.writeln('\'\'\';');
      sb.writeln();

      String relativePath = file.path.substring(inputDir.path.length);
      relativePath = '$relativePath.dart';
      final outputFile = File(outputDir.path + relativePath);
      outputFile.createSync(recursive: true);
      outputFile.writeAsStringSync(sb.toString());
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
      final name = filename.snakeCase;
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
      final name = filename.snakeCase;
      final orgFilename = relativePath.replaceAll('.dart', '');
      sb.writeln('  \'$orgFilename\': $name.template,');
    }
  }
  sb.writeln('};');
  sb.writeln();

  final outputFile = File('${outputDir.path}/template.dart');
  outputFile.createSync(recursive: true);
  outputFile.writeAsStringSync(sb.toString());
}
