import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pptx/flutter_pptx.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  test(
    'check sample presentation',
    () async {
      final pres = Powerpoint();

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
    },
    timeout: const Timeout(Duration(minutes: 2)),
  );
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
