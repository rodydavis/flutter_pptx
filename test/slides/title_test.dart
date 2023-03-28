import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pptx/src/classes/arc.dart';
import 'package:flutter_pptx/src/slides/title.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  test('check title slide', () {
    final slide = SlideTitle();
    final arc = Arc()..init([slide]);
    final result = slide.renderTemplate(arc);

    expect(result.isNotEmpty, true);
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
