// ignore_for_file: avoid_single_cascade_in_expression_statements

import 'package:flutter/material.dart';
import 'package:flutter_pptx/src/markdown.dart';
import 'package:flutter_pptx/src/slides/big_fact.dart';
import 'package:flutter_pptx/src/slides/blank.dart';
import 'package:flutter_pptx/src/slides/section.dart';
import 'package:flutter_pptx/src/slides/statement.dart';
import 'package:flutter_pptx/src/slides/title.dart';
import 'package:flutter_pptx/src/slides/title_and_bullets.dart';
import 'package:flutter_pptx/src/slides/title_only.dart';

import 'package:flutter_test/flutter_test.dart';

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
  WidgetsFlutterBinding.ensureInitialized();

  group('markdown tests', () {
    group('slide templates', () {
      test('title, subtitle and content', () {
        final sb = StringBuffer();
        sb.writeln('---');
        sb.writeln('# Title');
        sb.writeln('## Subtitle');
        sb.writeln('Content');
        final slides = createSlidesFromMarkdown(sb.toString());
        expect(slides.length, 1);
        expect(slides[0].runtimeType, TitleAndBullets);
      });
      test('title and subtitle', () {
        final sb = StringBuffer();
        sb.writeln('---');
        sb.writeln('# Title');
        sb.writeln('## Subtitle');
        final slides = createSlidesFromMarkdown(sb.toString());
        expect(slides.length, 1);
        expect(slides[0].runtimeType, SlideTitleOnly);
      });
      test('title and content', () {
        final sb = StringBuffer();
        sb.writeln('---');
        sb.writeln('# Title');
        sb.writeln('Content');
        final slides = createSlidesFromMarkdown(sb.toString());
        expect(slides.length, 1);
        expect(slides[0].runtimeType, SlideTitleOnly);
      });
      test('title', () {
        final sb = StringBuffer();
        sb.writeln('---');
        sb.writeln('# Title');
        final slides = createSlidesFromMarkdown(sb.toString());
        expect(slides.length, 1);
        expect(slides[0].runtimeType, SlideTitle);
      });
      test('blank', () {
        final sb = StringBuffer();
        sb.writeln('---');
        final slides = createSlidesFromMarkdown(sb.toString());
        expect(slides.length, 1);
        expect(slides[0].runtimeType, SlideBlank);
      });
      test('content', () {
        final sb = StringBuffer();
        sb.writeln('---');
        sb.writeln('Content');
        final slides = createSlidesFromMarkdown(sb.toString());
        expect(slides.length, 1);
        expect(slides[0].runtimeType, SlideSection);
      });
      test('statement', () {
        final sb = StringBuffer();
        sb.writeln('---');
        sb.writeln('# Statement {.big}');
        final slides = createSlidesFromMarkdown(sb.toString());
        expect(slides.length, 1);
        expect(slides[0].runtimeType, SlideStatement);
      });
      test('fact', () {
        final sb = StringBuffer();
        sb.writeln('---');
        sb.writeln('# 100% {.big}');
        sb.writeln('Info about the fact');
        final slides = createSlidesFromMarkdown(sb.toString());
        expect(slides.length, 1);
        expect(slides[0].runtimeType, SlideBigFact);
      });
    });
  });

  test(
    'check markdown presentation',
    () async {
      final slides = createSlidesFromMarkdown(testMarkdown);

      expect(slides.isNotEmpty, true);
      expect(slides.length, 8);
    },
  );
}
