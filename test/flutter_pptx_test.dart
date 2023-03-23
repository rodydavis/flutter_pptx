import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pptx/flutter_pptx.dart';

void main() {
  test('check presentation', () async {
    final pres = Powerpoint();
    // pres.addIntro('Test');
    pres.addTextualSlide('Test Header', ['Test 1', 'Test 2']);

    final bytes = await pres.save();
    if (bytes != null) {
      // Save to directory
      for (final entry in pres.context.archive.files.entries) {
        final name = entry.key;
        final value = entry.value;
        if (value is List<int>) {
          await saveFile('./build/pptx/$name', bytes: value);
        } else if (value is String) {
          await saveFile('./build/pptx/$name', string: value);
        }
      }

      await saveFile('./samples/pptx/sample.pptx', bytes: bytes);
    }

    expect(bytes != null && bytes.isNotEmpty, true);
  });
}

Future<void> saveFile(
  String name, {
  List<int>? bytes,
  String? string,
}) async {
  final file = File(name);
  if (!await file.exists()) {
    await file.create(recursive: true);
  }
  if (bytes != null) await file.writeAsBytes(bytes);
  if (string != null) await file.writeAsString(string);
}
