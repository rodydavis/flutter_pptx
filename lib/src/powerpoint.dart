import 'dart:convert';

import 'classes/app.dart';
import 'classes/content_type.dart';
import 'classes/coords.dart';
import 'classes/core.dart';
import 'classes/layout.dart';
import 'classes/presentation.dart';
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

    final slides = <s.Slide>[];

    for (var i = 0; i < 16; i++) {
      final slide = s.Slide(title: 'Slide $i');
      slide.index = i;
      slide.isLast = i == 15;
      slide.id = ++id;
      slide.rId = ++rId;
      slides.add(slide);
    }

    final notes = <n.Notes>[];

    for (var i = 0; i <= 12; i++) {
      final note = n.Notes(notes: 'SPEAKER NOTES');
      note.index = i;
      note.isLast = i == 12;
      note.id = ++id;
      note.rId = ++rId;
      notes.add(note);
    }

    final files = <String, Object>{
      'docProps/app.xml': App(
        slides: slides,
      ),
      'docProps/core.xml': Core(),
      'ppt/presentation.xml': Presentation(
        layout: Layout(
          type: 'custom',
          width: 24384000,
          height: 13716000,
        ),
        slides: slides,
      ),
      '[Content_Types].xml': ContentType(
        notes: notes,
        slides: slides,
      ),
    };

    for (final entry in files.entries) {
      final str = entry.value.toString();
      context.archive.addFile(entry.key, str);
    }

    // // Render/save generic stuff
    // context.archive.addFile(
    //   '[Content_Types].xml',
    //   content_type_xml.renderString(
    //     content_type_xml.Source.create(
    //       fileTypes: fileTypes,
    //       slideCount: slides.length,
    //     ),
    //   ),
    // );
    // context.archive.addFile(
    //   'ppt/_rels/presentation.xml.rels',
    //   presentation_xml_rel.renderString(
    //     presentation_xml_rel.Source.create(
    //       slides.length,
    //     ),
    //   ),
    // );
    // context.archive.addFile(
    //   'ppt/presentation.xml',
    //   presentation_xml.renderString(
    //     presentation_xml.Source(
    //       layout: layout,
    //       slides: [
    //         for (var i = 0; i < slides.length; i++)
    //           presentation_xml.Slide.fromIndex(i, slides[i].notes)
    //       ],
    //     ),
    //   ),
    // );
    // context.archive.addFile(
    //   'docProps/app.xml',
    //   app_xml.renderString(
    //     app_xml.Source.slides(
    //       slides.map((e) => app_xml.Slide(title: e.title)).toList(),
    //     ),
    //   ),
    // );

    // // Save slides
    // List<Notes> notes = [];
    // for (var i = 0; i < slides.length; i++) {
    //   final slide = slides[i];
    //   if (slide.notes.trim().isNotEmpty) {
    //     notes.add(Notes(slideIndex: i, notes: slide.notes));
    //   }
    // }
    // for (var i = 0; i < slides.length; i++) {
    //   final slide = slides[i];
    //   final notesIndex = notes.indexWhere((n) => n.slideIndex == i);
    //   await slide.save(context, i + 1, notesIndex + 1);
    // }
    // for (var i = 0; i < notes.length; i++) {
    //   final note = notes[i];
    //   await note.save(context, i + 1, i + 1);
    // }

    // Create .pptx file
    return context.archive.toBytes();
  }
}
