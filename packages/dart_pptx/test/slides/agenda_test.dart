import 'dart:io';

import 'package:dart_pptx/dart_pptx.dart';
import 'package:test/test.dart';

import '../utils/check_pptx.dart';
import '../utils/save_pptx.dart';
import '../utils/xml.dart';

void main() {
  group('Agenda slide tests', () {
    var pres = PowerPoint();
    var files = <String, List<int>>{};
    final tempDir = Directory.systemTemp.createTempSync('dart_pptx_test');
    final tempFile = File('${tempDir.path}/test.pptx');

    Future<void> save() async {
      final bytes = await pres.save();
      await savePptx(tempFile.path, bytes!);
      files = await checkPptx(tempFile.path);
    }

    setUp(() async {
      pres = PowerPoint();
      pres.addAgendaSlide();
      await save();
    });

    tearDown(() {
      tempFile.deleteSync();
      files.clear();
    });

    test('Check if added', () async {
      final slide = pres.slides[0];

      expect(slide, isNotNull);
      expect(slide.runtimeType, SlideAgenda);
    });

    test('ppt/slides/slide1.xml', () async {
      const title = 'SLIDE_TITLE';
      const subtitle = 'SLIDE_SUBTITLE';
      const topics = 'SLIDE_TOPICS';
      String content = getXml(files['ppt/slides/slide1.xml']!);

      expect(content, contains('<p:sld'));
      expect(content.indexOf(title), -1);
      expect(content.indexOf(subtitle), -1);
      expect(content.indexOf(topics), -1);

      final slide = pres.slides[0] as SlideAgenda;
      slide.title = TextValue.uniform(title);
      slide.subtitle = TextValue.uniform(subtitle);
      slide.topics = TextValue.uniform(topics);

      await save();
      content = getXml(files['ppt/slides/slide1.xml']!);

      expect(content.indexOf(title), isNot(-1));
      expect(content.indexOf(subtitle), isNot(-1));
      expect(content.indexOf(topics), isNot(-1));
    });

    test('ppt/slides/_rels/slide1.xml.rels', () {
      final content = getXml(files['ppt/slides/_rels/slide1.xml.rels']!);

      expect(content, contains('<Relationship Id="rId1"'));
      expect(content, contains('slideLayout9.xml"'));
    });

    test('ppt/presentation.xml', () {
      final content = getXml(files['ppt/presentation.xml']!);

      expect(content, contains('<p:sldId id="256" r:id="rId8"/>'));
    });

    test('ppt/_rels/presentation.xml.rels', () {
      final content = getXml(files['ppt/_rels/presentation.xml.rels']!);

      expect(content, contains('<Relationship Id="rId1"'));
    });
  });
}
