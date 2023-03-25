import 'dart:convert';

import 'classes/app.dart';
import 'classes/content_type.dart';
import 'classes/coords.dart';
import 'classes/core.dart';
import 'classes/layout.dart';
import 'classes/notes_rel.dart';
import 'classes/presentation.dart';
import 'classes/slide/title.dart';
import 'classes/slide_rel.dart';
import 'context.dart';
import 'slide/intro.dart';
import 'slide/notes.dart';
import 'slide/pictorial.dart';
import 'slide/picture_description.dart';
import 'slide/slide.dart';
import 'slide/text_picture_split.dart';
import 'slide/textual.dart';
import 'template/template.dart';

import 'views/content_type.xml.dart' as content_type_xml;
import 'views/presentation.xml.rel.dart' as presentation_xml_rel;
import 'views/presentation.xml.dart' as presentation_xml;
import 'views/app.xml.dart' as app_xml;
import 'classes/slide.dart' as s;
import 'classes/notes.dart' as n;

class Powerpoint {
  final context = PresentationContext.create();
  Layout layout = Layout.screen16x9();
  List<Slide> slides = [];

  void setLayout(Layout layout) {
    this.layout = layout;
  }

  Slide addSlide(Slide slide) {
    slides.add(slide);
    return slide;
  }

  Slide addIntro(
    String title, {
    String? subtitile,
  }) {
    final slide = Intro(
      title: title,
      subtitile: subtitile ?? '', // TODO: make this optional
    );
    final idx = slides.indexWhere((s) => s is Intro);
    if (idx != -1) {
      slides[idx] = slide;
    } else {
      addSlide(slide);
    }
    return slide;
  }

  Slide addTextualSlide(String title, List<String> content) {
    return addSlide(Textual(
      title: title,
      content: content,
    ));
  }

  Slide addPictorialSlide(
    String title,
    String image, {
    Coords? coords,
  }) {
    return addSlide(Pictorial(
      title: title,
      imagePath: image,
      coords: coords,
    ));
  }

  Slide addTextPictureSlide(
    String title,
    String image, {
    Coords? coords,
    List<String> content = const [],
  }) {
    final slide = TextPicSplit(
      title: title,
      imagePath: image,
      content: content,
      coords: coords,
    );
    return addSlide(slide);
  }

  Slide addPictureDescriptionSlide(
    String title,
    String image, {
    Coords? coords,
    List<String> content = const [],
  }) {
    final slide = DescriptionPic(
      title: title,
      imagePath: image,
      coords: coords,
      content: content,
    );
    return addSlide(slide);
  }

  List<String> get fileTypes {
    final types = <String>[];
    for (final slide in slides) {
      final type = slide.fileType();
      if (type != null && !types.contains(type)) {
        types.add(type);
      }
    }
    return types;
  }

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

    final slides = <s.Slide>[];
    final notes = <n.Notes>[];

    const count = 50;
    for (var i = 0; i <= count; i++) {
      final item = SlideTitle(
        title: 'Slide $i',
        speakerNotes: 'SPEAKER NOTES',
      );
      slides.add(item);

      n.Notes? note;

      if (item.speakerNotes.isNotEmpty) {
        note = n.Notes(
          notes: item.speakerNotes,
          slideIndex: i,
        );
        notes.add(note);
      }
    }

    for (var i = 0; i < slides.length; i++) {
      final item = slides[i];
      item.index = i;
      item.isLast = i == slides.length - 1;
      item.id = ++id;
      item.rId = ++rId;
      offset = item.createIds(offset);

      files['ppt/slides/slide${item.order}.xml'] = item;

      final rel = SlideRel(
        layoutId: item.layoutId,
        notes: [],
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

      final slide = slides[note.slideIndex];
      final slideItem =
          files['ppt/slides/_rels/slide${slide.order}.xml.rels'] as SlideRel;
      final slideNotes = slideItem.notes.toList();
      slideNotes.add(note);
      slideItem.notes = slideNotes;

      files['ppt/notesSlides/notesSlide${note.order}.xml'] = note;

      final rel = NotesRel(slideOrder: slide.order);
      files['ppt/notesSlides/_rels/notesSlide${note.order}.xml.rels'] = rel;
    }

    final pres = Presentation(
      layout: Layout(
        type: 'custom',
        width: 24384000,
        height: 13716000,
      ),
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

    // for (var i = 0; i < slides.length; i++) {
    //   final item = SlideTitle(title: 'Slide $i');
    //   offset = item.createIds(offset);
    //   item.index = i;
    //   item.isLast = i == 15;
    //   item.id = ++id;
    //   item.rId = ++rId;
    //   files['ppt/slides/slide${item.order}.xml'] = item;
    //   final rel = SlideRel(
    //     layoutId: item.layoutId,
    //     notes: [],
    //     images: [],
    //   );
    //   files['ppt/slides/_rels/slide${item.order}.xml.rels'] = rel;
    // }

    for (final entry in files.entries) {
      final str = entry.value.toString();
      context.archive.addFile(entry.key, str);
    }

    // Create .pptx file
    return context.archive.toBytes();
  }
}
