// ignore_for_file: avoid_single_cascade_in_expression_statements

import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pptx/flutter_pptx.dart';

import 'base_widget.dart';
import 'save_file.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  test(
    'check sample presentation',
    () async {
      final pres = Powerpoint();

      pres.addTitleSlide(
        title: 'Slide one'.toTextValue(),
      );

      pres.addTitleAndPhotoSlide(
        title: 'Slide two'.toTextValue(),
        image: ImageReference(
          path: './samples/images/sample_gif.gif',
          name: 'Sample Gif',
        ),
      );

      pres.addTitleAndPhotoAltSlide(
        title: 'Slide three'.toTextValue(),
        image: ImageReference(
          path: './samples/images/sample_jpg.jpg',
          name: 'Sample Jpg',
        ),
      );

      pres.addTitleAndBulletsSlide(
        title: 'Slide three'.toTextValue(),
        bullets: [
          'Bullet 1',
          'Bullet 2',
          'Bullet 3',
          'Bullet 4',
        ].map((e) => e.toTextValue()).toList(),
      )..speakerNotes = TextValue.uniform('This is a note!');

      pres.addBulletsSlide(
        bullets: [
          'Bullet 1',
          'Bullet 2',
          'Bullet 3',
          'Bullet 4',
        ].map((e) => e.toTextValue()).toList(),
      )..speakerNotes = TextValue.singleLine([
          TextItem('This '),
          TextItem('is ', isBold: true),
          TextItem('a ', isUnderline: true),
          TextItem('note!'),
        ]);

      pres.addTitleBulletsAndPhotoSlide(
        title: 'Slide five'.toTextValue(),
        image: ImageReference(
          path: './samples/images/sample_jpg.jpg',
          name: 'Sample Jpg',
        ),
        bullets: [
          'Bullet 1',
          'Bullet 2',
          'Bullet 3',
          'Bullet 4',
        ].map((e) => e.toTextValue()).toList(),
      );

      pres.addSectionSlide(
        section: 'Section 1'.toTextValue(),
      )..speakerNotes = TextValue.multiLine([
          TextValueLine(values: [
            TextItem('This '),
            TextItem('is ', isBold: true),
            TextItem('a ', isUnderline: true),
            TextItem('note 1!'),
          ]),
          TextValueLine(values: [
            TextItem('This '),
            TextItem('is ', isBold: true),
            TextItem('a ', isUnderline: true),
            TextItem('note 2!'),
          ]),
        ]);

      pres.addTitleOnlySlide(
        title: 'Title 1'.toTextValue(),
        subtitle: 'Subtitle 1'.toTextValue(),
      );

      pres.addAgendaSlide(
        title: 'Title 1'.toTextValue(),
        subtitle: 'Subtitle 1'.toTextValue(),
        topics: 'Topics 1'.toTextValue(),
      );

      pres.addStatementSlide(
        statement: 'Statement 1'.toTextValue(),
      );

      pres.addBigFactSlide(
        fact: 'Title 1'.toTextLine(),
        information: 'Fact 1'.toTextValue(),
      );

      pres.addQuoteSlide(
        quote: 'Quote 1'.toTextLine(),
        attribution: 'Attribution 1'.toTextValue(),
      );

      pres.addPhoto3UpSlide(
        image1: ImageReference(
          path: './samples/images/sample_gif.gif',
          name: 'Sample Gif',
        ),
        image2: ImageReference(
          path: './samples/images/sample_jpg.jpg',
          name: 'Sample Jpg',
        ),
        image3: ImageReference(
          path: './samples/images/sample_png.png',
          name: 'Sample Png',
        ),
      );

      pres.addPhotoSlide(
        image: ImageReference(
          path: './samples/images/sample_gif.gif',
          name: 'Sample Gif',
        ),
      );

      pres.addBlankSlide();

      pres.addBlankSlide()..background.color = '000000';

      pres.addBlankSlide()
        ..background.image = ImageReference(
          path: './samples/images/sample_gif.gif',
          name: 'Sample Gif',
        );

      await pres.addWidgetSlide(Center(
        child: Container(
            padding: const EdgeInsets.all(30.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent, width: 5.0),
              color: Colors.redAccent,
            ),
            child: const Text("This is an invisible widget")),
      ));

      pres.showSlideNumber = true;

      final bytes = await pres.save();
      if (bytes != null) {
        // Save to directory
        final dir = Directory('./build/pptx');
        if (!await dir.exists()) {
          await dir.create(recursive: true);
        } else {
          await dir.delete(recursive: true);
          await dir.create(recursive: true);
        }
        for (final entry in pres.context.archive.files.entries) {
          final name = entry.key;
          final value = entry.value;
          if (value is List<int>) {
            await saveFile('${dir.path}/$name', bytes: value);
          } else if (value is String) {
            await saveFile('${dir.path}/$name', string: value);
          }
        }

        await saveFile('./samples/pptx/sample.pptx', bytes: bytes);
      }

      expect(bytes != null && bytes.isNotEmpty, true);
    },
    timeout: const Timeout(Duration(minutes: 2)),
  );
}
