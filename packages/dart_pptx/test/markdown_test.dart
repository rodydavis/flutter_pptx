// ignore_for_file: avoid_single_cascade_in_expression_statements

import 'package:dart_pptx/dart_pptx.dart';
import 'package:dart_pptx/src/markdown.dart';
import 'package:test/test.dart';

const testMarkdown = r'''
---
# Title {.big}
---
# Title
## Subtitle
---
# Title
Content
---
# Title
## Subtitle
Content
---
# Title
---
# Statement {.big}
---
# 100% {.big}
Info about the fact
---
''';

void main() {
  group('markdown tests', () {
    group('slide templates', () {
      test('title, subtitle and content', () async {
        final sb = StringBuffer();
        sb.writeln('---');
        sb.writeln('# Title');
        sb.writeln('## Subtitle');
        sb.writeln('Content');
        final slides = await createSlidesFromMarkdown(sb.toString());
        expect(slides.length, 1);
        expect(slides[0].runtimeType, SlideTitleAndBullets);
      });
      test('title and subtitle', () async {
        final sb = StringBuffer();
        sb.writeln('---');
        sb.writeln('# Title');
        sb.writeln('## Subtitle');
        final slides = await createSlidesFromMarkdown(sb.toString());
        expect(slides.length, 1);
        expect(slides[0].runtimeType, SlideTitleOnly);
      });
      test('title and content', () async {
        final sb = StringBuffer();
        sb.writeln('---');
        sb.writeln('# Title');
        sb.writeln('Content');
        final slides = await createSlidesFromMarkdown(sb.toString());
        expect(slides.length, 1);
        expect(slides[0].runtimeType, SlideTitleOnly);
      });
      test('title', () async {
        final sb = StringBuffer();
        sb.writeln('---');
        sb.writeln('# Title');
        final slides = await createSlidesFromMarkdown(sb.toString());
        expect(slides.length, 1);
        expect(slides[0].runtimeType, SlideTitle);
      });
      test('blank', () async {
        final sb = StringBuffer();
        sb.writeln('---');
        final slides = await createSlidesFromMarkdown(sb.toString());
        expect(slides.length, 1);
        expect(slides[0].runtimeType, SlideBlank);
      });
      test('content', () async {
        final sb = StringBuffer();
        sb.writeln('---');
        sb.writeln('Content');
        final slides = await createSlidesFromMarkdown(sb.toString());
        expect(slides.length, 1);
        expect(slides[0].runtimeType, SlideSection);
      });
      test('statement', () async {
        final sb = StringBuffer();
        sb.writeln('---');
        sb.writeln('# Statement {.big}');
        final slides = await createSlidesFromMarkdown(sb.toString());
        expect(slides.length, 1);
        expect(slides[0].runtimeType, SlideStatement);
      });
      test('fact', () async {
        final sb = StringBuffer();
        sb.writeln('---');
        sb.writeln('# 100% {.big}');
        sb.writeln('Info about the fact');
        final slides = await createSlidesFromMarkdown(sb.toString());
        expect(slides.length, 1);
        expect(slides[0].runtimeType, SlideBigFact);
      });
    });
  });

  test(
    'check markdown presentation',
    () async {
      final slides = await createSlidesFromMarkdown(testMarkdown);

      expect(slides.isNotEmpty, true);
      expect(slides.length, 8);
    },
  );
}
