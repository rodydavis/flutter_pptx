import 'dart:io';

import 'package:dart_pptx/dart_pptx.dart';
import 'package:test/test.dart';

import '../utils/check_pptx.dart';
import '../utils/save_pptx.dart';
import '../utils/xml.dart';

void main() {
  group('Quote slide tests', () {
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
      pres.addQuoteSlide();
      await save();
    });

    tearDown(() {
      tempFile.deleteSync();
      files.clear();
    });

    test('Check if added', () async {
      final slide = pres.slides[0];

      expect(slide, isNotNull);
      expect(slide.runtimeType, SlideQuote);
    });

    test('ppt/slides/slide1.xml', () async {
      const quote = 'SLIDE_QUOTE';
      const attribution = 'SLIDE_ATTRIBUTION';
      String content = getXml(files['ppt/slides/slide1.xml']!);

      expect(content, contains('<p:sld'));
      expect(content.indexOf(quote), -1);
      expect(content.indexOf(attribution), -1);

      final slide = pres.slides[0] as SlideQuote;
      slide.quote = quote.toTextLine();
      slide.attribution = attribution.toTextValue();

      await save();
      content = getXml(files['ppt/slides/slide1.xml']!);

      expect(content.indexOf(quote), isNot(-1));
      expect(content.indexOf(attribution), isNot(-1));
    });

    test('ppt/slides/_rels/slide1.xml.rels', () {
      final content = getXml(files['ppt/slides/_rels/slide1.xml.rels']!);

      expect(content, contains('<Relationship Id="rId1"'));
      expect(content, contains('slideLayout12.xml"'));
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
