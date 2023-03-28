// ignore_for_file: avoid_single_cascade_in_expression_statements

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pptx/flutter_pptx.dart';

import 'save_file.dart';

const testMarkdown = r'''
---
# Title
## Subtitle
---
# Slide 2

''';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  test(
    'check markdown presentation',
    () async {
      final pres = Powerpoint();

      pres.addSlidesFromMarkdown(testMarkdown);

      final bytes = await pres.save();

      expect(bytes != null && bytes.isNotEmpty, true);

      await saveFile('./samples/pptx/sample.pptx', bytes: bytes);
    },
    timeout: const Timeout(Duration(minutes: 2)),
  );
}
