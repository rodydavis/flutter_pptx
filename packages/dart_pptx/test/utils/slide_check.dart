import 'dart:io';

import 'package:dart_pptx/dart_pptx.dart';
import 'package:test/test.dart';

void slideCheck(
  String name,
  void Function(PowerPoint pres, String file) callback,
) {
  group('$name tests', () {
    var pres = PowerPoint();
    final tempDir = Directory.systemTemp.createTempSync('dart_pptx_test');
    final tempFile = File('${tempDir.path}/$name.pptx');

    setUp(() {
      pres = PowerPoint();
    });

    tearDown(() {
      tempFile.deleteSync();
    });

    callback(pres, tempFile.path);
  });
}
