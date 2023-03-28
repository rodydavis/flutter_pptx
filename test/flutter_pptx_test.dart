// ignore_for_file: avoid_single_cascade_in_expression_statements

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

      pres.addTitle(
        title: 'Slide one',
      );

      pres.addTitleAndPhoto(
        title: 'Slide two',
        imagePath: './samples/images/sample_gif.gif',
        imageName: 'Sample Gif',
      );

      pres.addTitleAndPhotoAlt(
        title: 'Slide three',
        imagePath: './samples/images/sample_jpg.jpg',
        imageName: 'Sample Jpg',
      );

      pres.addTitleAndBullets(
        title: 'Slide three',
        bullets: [
          'Bullet 1',
          'Bullet 2',
          'Bullet 3',
          'Bullet 4',
        ],
      )..speakerNotes = TextValue.uniform('This is a note!');

      pres.addBullets(
        bullets: [
          'Bullet 1',
          'Bullet 2',
          'Bullet 3',
          'Bullet 4',
        ],
      )..speakerNotes = TextValue.singleLine([
          TextItem('This '),
          TextItem('is ', isBold: true),
          TextItem('a ', isUnderline: true),
          TextItem('note!'),
        ]);

      pres.addSlideTitleBulletsAndPhoto(
        title: 'Slide five',
        imagePath: './samples/images/sample_jpg.jpg',
        imageName: 'Sample Jpg',
        bullets: [
          'Bullet 1',
          'Bullet 2',
          'Bullet 3',
          'Bullet 4',
        ],
      );

      pres.addSection(
        section: 'Section 1',
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

      pres.addSlideTitleOnly(
        title: 'Title 1',
        subtitle: 'Subtitle 1',
      );

      pres.addSlideAgenda(
        title: 'Title 1',
        subtitle: 'Subtitle 1',
        topics: 'Topics 1',
      );

      pres.addSlideStatement(
        statement: 'Statement 1',
      );

      pres.addBigFact(
        fact: 'Title 1',
        information: 'Fact 1',
      );

      pres.addSlideQuote(
        quote: 'Quote 1',
        attribution: 'Attribution 1',
      );

      pres.addSlidePhoto3Up(
        image1Path: './samples/images/sample_gif.gif',
        image2Path: './samples/images/sample_jpg.jpg',
        image3Path: './samples/images/sample_png.png',
      );

      pres.addSlidePhoto(
        imagePath: './samples/images/sample_gif.gif',
      );

      pres.addSlideBlank();

      pres.addSlideBlank()..background.color = '000000';

      pres.addSlideBlank()
        ..background.image = ImageReference(
          path: './samples/images/sample_gif.gif',
          name: 'Sample Gif',
        );

      await pres.addSlideWidget(BaseWidget(
        child: Center(
          child: Container(
              padding: const EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent, width: 5.0),
                color: Colors.redAccent,
              ),
              child: const Text("This is an invisible widget")),
        ),
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

class BaseWidget extends StatelessWidget {
  const BaseWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: child,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
