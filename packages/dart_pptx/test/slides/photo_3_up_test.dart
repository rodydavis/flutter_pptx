import 'dart:io';

import 'package:dart_pptx/dart_pptx.dart';
import 'package:test/test.dart';

import '../utils/broken_image.dart';
import '../utils/check_pptx.dart';
import '../utils/save_pptx.dart';
import '../utils/xml.dart';

void main() {
  group('Photo 3 up slide tests', () {
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
      pres.addPhoto3UpSlide();
      await save();
    });

    tearDown(() {
      tempFile.deleteSync();
      files.clear();
    });

    test('Check if added', () async {
      final slide = pres.slides[0];

      expect(slide, isNotNull);
      expect(slide.runtimeType, SlidePhoto3Up);
    });

    test('ppt/slides/slide1.xml', () async {
      const image1Desc = 'IMAGE_1_DESCRIPTION';
      const image2Desc = 'IMAGE_2_DESCRIPTION';
      const image3Desc = 'IMAGE_3_DESCRIPTION';
      String content = getXml(files['ppt/slides/slide1.xml']!);

      expect(content, contains('<p:sld'));
      expect(content.indexOf(image1Desc), -1);
      expect(content.indexOf(image2Desc), -1);
      expect(content.indexOf(image3Desc), -1);
      expect(files['ppt/media/image1.png'], isNotNull);

      final slide = pres.slides[0] as SlidePhoto3Up;
      slide.image1 = ImageReference(
        path: BROKEN_IMAGE,
        name: image1Desc,
      );
      slide.image2 = ImageReference(
        path: BROKEN_IMAGE,
        name: image2Desc,
      );
      slide.image3 = ImageReference(
        path: BROKEN_IMAGE,
        name: image3Desc,
      );

      await save();
      content = getXml(files['ppt/slides/slide1.xml']!);

      expect(content.indexOf(image1Desc), isNot(-1));
      expect(content.indexOf(image2Desc), isNot(-1));
      expect(content.indexOf(image3Desc), isNot(-1));
      expect(files['ppt/media/image1.png'], isNotNull);
    });

    test('ppt/slides/_rels/slide1.xml.rels', () {
      final content = getXml(files['ppt/slides/_rels/slide1.xml.rels']!);

      expect(content, contains('<Relationship Id="rId1"'));
      expect(content, contains('slideLayout13.xml"'));
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
