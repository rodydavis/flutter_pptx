import 'package:flutter_pptx/src/context.dart';
import '../views/notes/rel.xml.dart' as rel_xml;
import '../views/notes/slide.xml.dart' as slide_xml;
import 'dart:async';

import 'slide.dart';

class Notes extends Slide {
  final int slideIndex;

  Notes({
    required this.slideIndex,
    required String notes,
  }) {
    setSpeakerNotes(notes);
  }

  @override
  FutureOr<void> saveRelXml(
    PresentationContext context,
    int index,
    int notesIndex,
  ) {}

  @override
  FutureOr<void> saveSlideXml(PresentationContext context, int index) {
    final source = slide_xml.Source(
      notes: notes,
    );
    final result = slide_xml.renderString(source);
    final path = 'ppt/notesSlides/notesSlide$index.xml';
    context.archive.addFile(path, result);
  }

  @override
  String get title => notes;
}
