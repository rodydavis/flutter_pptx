import 'dart:convert';

import 'classes/app.dart';
import 'classes/content_type.dart';
import 'classes/core.dart';
import 'classes/images.dart';
import 'classes/layout.dart';
import 'classes/media_slide.dart';
import 'classes/notes.dart';
import 'classes/notes_rel.dart';
import 'classes/presentation.dart';
import 'classes/slide.dart';
import 'classes/slide_rel.dart';
import 'slides/title.dart';
import 'slides/title_and_photo.dart';
import 'context.dart';
import 'template/template.dart';

class Powerpoint {
  var context = PresentationContext();
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

  Slide addSlide(
    Slide slide, {
    String? notes,
    bool? showSlideNumber,
  }) {
    slide.speakerNotes = notes ?? slide.speakerNotes;
    slide.slideNumber = showSlideNumber ?? _showSlideNumber;
    slides.add(slide);
    return slide;
  }

  Slide addTitle({
    required String title,
    String? author,
    String? notes,
    bool? showSlideNumber,
  }) =>
      addSlide(
        SlideTitle(
          title: title,
          author: author,
        ),
        notes: notes,
        showSlideNumber: showSlideNumber,
      );

  Slide addTitleAndPhoto({
    required String title,
    required String imagePath,
    String? imageName,
    String? imageDescription,
    String? author,
    String? subtitle,
    String? notes,
    bool? showSlideNumber,
  }) {
    final imgName = imageName ?? imagePath.split('/').last.split('.').first;
    return addSlide(
      SlideTitleAndPhoto(
        title: title,
        subtitle: subtitle,
        image: ImageReference(
          path: imagePath,
          name: imgName,
          description: imageDescription ?? imgName,
        ),
        author: author,
      ),
      notes: notes,
      showSlideNumber: showSlideNumber,
    );
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
    final notes = <Notes>[];
    final media = <ImageReference>[];

    for (final item in slides) {
      if (item is MediaSlide) {
        for (final image in item.images) {
          final existingIdx = media.indexWhere((e) => e.path == image.path);
          if (existingIdx == -1) media.add(image);
        }
      }
    }

    for (var i = 0; i < media.length; i++) {
      final item = media[i];
      item.index = i + 1;
      item.isLast = i == media.length - 1;
      item.id = ++id;
      item.rId = ++rId;
    }

    for (var i = 0; i < slides.length; i++) {
      final item = slides[i];
      item.index = i;
      item.isLast = i == slides.length - 1;
      item.id = ++id;
      item.rId = ++rId;
      offset = item.createIds(offset);

      Notes? note;
      final images = <ImageReference>[];

      if (item is MediaSlide) {
        for (final img in item.images) {
          final existingIdx = media.indexWhere((e) => e.path == img.path);
          if (existingIdx != -1) images.add(media[existingIdx]);
        }
      }

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
        images: images,
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
      'docProps/app.xml': App(slides: slides),
      'docProps/core.xml': Core(),
      'ppt/presentation.xml': pres,
      'ppt/_rels/presentation.xml.rels': pres.createRel(),
      '[Content_Types].xml': ContentType(notes: notes, slides: slides),
    });

    // Copy assets
    final futures = <Future>[];
    for (final item in media) {
      futures.add(Future.sync(() async {
        final bytes = await context.assets.getImageData(item.path);
        if (bytes != null) {
          final imgName = 'image${item.order}.${item.ext}';
          // final fileName = imgName ?? path.basename(item.path);
          context.archive.addBinaryFile('ppt/media/$imgName', bytes);
        }
      }));
    }
    await Future.wait(futures);

    for (final entry in files.entries) {
      final str = entry.value.toString();
      context.archive.addFile(entry.key, str);
    }

    // Create .pptx file
    return context.archive.toBytes();
  }
}
