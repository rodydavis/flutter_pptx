// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import '../context.dart';
import 'slide.dart';
import '../views/textual_rel.xml.dart' as rel_xml;
import '../views/textual_slide.xml.dart' as slide_xml;

class Textual extends Slide {
  final String title;
  final List<String> content;

  Textual({
    required this.title,
    required this.content,
  });

  @override
  FutureOr<void> saveRelXml(PresentationContext context, int index) {
    final source = rel_xml.Source(
      index: index,
    );
    final result = rel_xml.renderString(source);
    final path = 'ppt/slides/_rels/slide$index.xml.rels';
    context.archive.saveStringFile(path, result);
  }

  @override
  FutureOr<void> saveSlideXml(PresentationContext context, int index) {
    final source = slide_xml.Source.content(
      title: title,
      content: content,
    );
    final result = slide_xml.renderString(source);
    final path = 'ppt/slides/slide$index.xml';
    context.archive.saveStringFile(path, result);
  }
}
