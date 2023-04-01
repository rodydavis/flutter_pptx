import 'dart:io';

import 'package:dart_pptx/dart_pptx.dart';

Future<void> main(List<String> arguments) async {
  if (arguments.length != 2) {
    print('Usage: md2pptx inputFile outputFile');
    return;
  }
  final inputFile = File(arguments[0]);
  if (!inputFile.existsSync()) {
    print('Input file does not exist');
    return;
  }
  final content = inputFile.readAsStringSync();
  final pres = PowerPoint();
  await pres.addSlidesFromMarkdown(content);
  final bytes = await pres.save();
  if (bytes == null) {
    print('Failed to save presentation');
    return;
  }

  final outputFile = File(arguments[1]);
  if (!outputFile.existsSync()) {
    outputFile.createSync(recursive: true);
  }
  outputFile.writeAsBytesSync(bytes);
  print('Saved ${bytes.length} bytes to ${outputFile.path}');
}
