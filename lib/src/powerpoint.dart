import 'classes/coords.dart';
import 'classes/layout.dart';
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
      context.archive.addFile(entry.key, entry.value.trim());
    }

    // Remove keep files
    context.archive.removeWhere((path, _) => path.endsWith('.keep'));

    // Render/save generic stuff
    context.archive.addFile(
      '[Content_Types].xml',
      content_type_xml.renderString(
        content_type_xml.Source.create(
          fileTypes: fileTypes,
          slideCount: slides.length,
        ),
      ),
    );
    context.archive.addFile(
      'ppt/_rels/presentation.xml.rels',
      presentation_xml_rel.renderString(
        presentation_xml_rel.Source.create(
          slides.length,
        ),
      ),
    );
    context.archive.addFile(
      'ppt/presentation.xml',
      presentation_xml.renderString(
        presentation_xml.Source(
          layout: layout,
          slides: [
            for (var i = 0; i < slides.length; i++)
              presentation_xml.Slide.fromIndex(i, slides[i].notes)
          ],
        ),
      ),
    );
    context.archive.addFile(
      'docProps/app.xml',
      app_xml.renderString(
        app_xml.Source.slides(
          slides.map((e) => app_xml.Slide(title: e.title)).toList(),
        ),
      ),
    );

    // Save slides
    List<Notes> notes = [];
    for (var i = 0; i < slides.length; i++) {
      final slide = slides[i];
      if (slide.notes.trim().isNotEmpty) {
        notes.add(Notes(slideIndex: i, notes: slide.notes));
      }
    }
    for (var i = 0; i < slides.length; i++) {
      final slide = slides[i];
      final notesIndex = notes.indexWhere((n) => n.slideIndex == i);
      await slide.save(context, i + 1, notesIndex + 1);
    }
    for (var i = 0; i < notes.length; i++) {
      final note = notes[i];
      await note.save(context, i + 1, i + 1);
    }

    // Create .pptx file
    return context.archive.toBytes();
  }
}
