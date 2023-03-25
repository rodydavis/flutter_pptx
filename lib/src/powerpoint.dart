import 'dart:convert';

import 'classes/app.dart';
import 'classes/content_type.dart';
import 'classes/core.dart';
import 'classes/layout.dart';
import 'classes/notes.dart';
import 'classes/notes_rel.dart';
import 'classes/presentation.dart';
import 'classes/slide.dart';
import 'classes/slide_rel.dart';
import 'classes/slide_templates/title.dart';
import 'context.dart';
import 'template/template.dart';

class Powerpoint {
  final context = PresentationContext.create();
  Layout layout = Layout(
    type: 'custom',
    width: 24384000,
    height: 13716000,
  );
  final slides = <Slide>[];

  bool _showSlideNumber = false;
  bool get showSlideNumber => _showSlideNumber;
  set showSlideNumber(bool value) {
    _showSlideNumber = value;
    for (var slide in slides) {
      if (slide is SlideTitle) {
        slide.slideNumber = _showSlideNumber;
      }
    }
  }

  void setLayout(Layout layout) {
    this.layout = layout;
  }

  Slide addSlide(Slide slide) {
    slides.add(slide);
    return slide;
  }

  Slide addTitle(
    String title, {
    String? author,
  }) {
    final slide = SlideTitle(title: title, author: author);
    return addSlide(slide);
  }

  // Slide addTextualSlide(String title, List<String> content) {
  //   return addSlide(Textual(
  //     title: title,
  //     content: content,
  //   ));
  // }

  // Slide addPictorialSlide(
  //   String title,
  //   String image, {
  //   Coords? coords,
  // }) {
  //   return addSlide(Pictorial(
  //     title: title,
  //     imagePath: image,
  //     coords: coords,
  //   ));
  // }

  // Slide addTextPictureSlide(
  //   String title,
  //   String image, {
  //   Coords? coords,
  //   List<String> content = const [],
  // }) {
  //   final slide = TextPicSplit(
  //     title: title,
  //     imagePath: image,
  //     content: content,
  //     coords: coords,
  //   );
  //   return addSlide(slide);
  // }

  // Slide addPictureDescriptionSlide(
  //   String title,
  //   String image, {
  //   Coords? coords,
  //   List<String> content = const [],
  // }) {
  //   final slide = DescriptionPic(
  //     title: title,
  //     imagePath: image,
  //     coords: coords,
  //     content: content,
  //   );
  //   return addSlide(slide);
  // }

  // List<String> get fileTypes {
  //   final types = <String>[];
  //   for (final slide in slides) {
  //     final type = slide.fileType();
  //     if (type != null && !types.contains(type)) {
  //       types.add(type);
  //     }
  //   }
  //   return types;
  // }

  Future<List<int>?> save() async {
    // Copy template to temp path
    for (final entry in templates.entries) {
      // final utf16 = Uint16List.fromList(entry.value);
      final name = entry.key;
      if (name.contains('.png')) {
        // Base64 decode
        final bytes = base64Decode(entry.value);
        context.archive.addBinaryFile(name, bytes);
      } else {
        final result = entry.value.trim();
        context.archive.addFile(entry.key, result);
      }
    }

    // Remove templates and keep files
    context.archive.removeWhere((path, _) => path.endsWith('.keep'));
    context.archive.removeWhere((path, _) => path.endsWith('.mustache'));

    int rId = 7;
    int id = 255;
    int offset = 150;

    final files = <String, Object>{};
    final notes = <Notes>[];

    for (var i = 0; i < slides.length; i++) {
      final item = slides[i];
      item.index = i;
      item.isLast = i == slides.length - 1;
      item.id = ++id;
      item.rId = ++rId;
      offset = item.createIds(offset);

      Notes? note;

      if (item.speakerNotes.isNotEmpty) {
        note = Notes(
          notes: item.speakerNotes,
          slideIndex: i,
        );
        notes.add(note);
      }

      files['ppt/slides/slide${item.order}.xml'] = item;

      final rel = SlideRel(
        layoutId: item.layoutId,
        notes: [if (note != null) note],
        images: [],
      );
      files['ppt/slides/_rels/slide${item.order}.xml.rels'] = rel;
    }

    for (var i = 0; i < notes.length; i++) {
      final note = notes[i];
      note.index = i;
      note.isLast = i == notes.length - 1;
      note.id = ++id;
      note.rId = ++rId;
      offset = note.createIds(offset);

      files['ppt/notesSlides/notesSlide${note.order}.xml'] = note;

      final slide = slides[note.slideIndex];
      final rel = NotesRel(slideOrder: slide.order);
      files['ppt/notesSlides/_rels/notesSlide${note.order}.xml.rels'] = rel;
    }

    final pres = Presentation(
      layout: layout,
      slides: slides,
    );

    files.addAll({
      'docProps/app.xml': App(
        slides: slides,
      ),
      'docProps/core.xml': Core(),
      'ppt/presentation.xml': pres,
      'ppt/_rels/presentation.xml.rels': pres.createRel(),
      '[Content_Types].xml': ContentType(
        notes: notes,
        slides: slides,
      ),
    });

    for (final entry in files.entries) {
      final str = entry.value.toString();
      context.archive.addFile(entry.key, str);
    }

    // Create .pptx file
    return context.archive.toBytes();
  }
}
