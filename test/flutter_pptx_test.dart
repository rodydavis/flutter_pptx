import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pptx/flutter_pptx.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  test(
    'check presentation',
    () async {
      final pres = Powerpoint();
      pres.addIntro('Bicycle Of the Mind', subtitile: 'created by Steve Jobs');
      final s = pres.addTextualSlide('Why Mac?', ['Its cool!', 'Its light!']);
      s.setSpeakerNotes('This is a note!');
      pres.addTextualSlide('Why Iphone?', ['Its fast!', 'Its cheap!']);
      pres.addPictorialSlide('JPG Logo', 'samples/images/sample_png.png');
      pres.addTextPictureSlide(
        'Text Pic Split',
        'samples/images/sample_png.png',
        content: ['Here is a string', 'here is another'],
      );
      pres.addPictorialSlide('PNG Logo', 'samples/images/sample_png.png');
      pres.addPictureDescriptionSlide(
        'Pic Desc',
        'samples/images/sample_png.png',
        content: ['Here is a string', 'here is another'],
      );
      pres.addPictureDescriptionSlide(
        'JPG Logo',
        'samples/images/sample_jpg.jpg',
        content: ['descriptions'],
      );
      pres.addPictorialSlide(
        'GIF Logo',
        'samples/images/sample_gif.gif',
        coords: Coords(
          x: 124200,
          y: 3356451,
          cx: 2895600,
          cy: 1013460,
        ),
      );
      pres.addTextualSlide('Why Android?', ['Its great!', 'Its sweet!']);

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
