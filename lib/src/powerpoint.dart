import 'dart:convert';

import 'classes/app.dart';
import 'classes/arc.dart';
import 'classes/content_type.dart';
import 'classes/core.dart';
import 'classes/images.dart';
import 'classes/layout.dart';
import 'classes/notes_rel.dart';
import 'classes/presentation.dart';
import 'classes/slide.dart';
import 'classes/text_value.dart';
import 'slides/bullets.dart';
import 'slides/title.dart';
import 'slides/title_and_bullets.dart';
import 'slides/title_and_photo.dart';
import 'context.dart';
import 'slides/title_and_photo_alt.dart';
import 'slides/title_bullets_and_photo.dart';
import 'template/template.dart';

class Powerpoint {
  // TODO: .fromMarkdown, Widget slide
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
    TextValue? notes,
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
    TextValue? notes,
    bool? showSlideNumber,
  }) =>
      addSlide(
        SlideTitle(
          title: TextValue.uniform(title),
          author: TextValue.uniform(author),
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
    TextValue? notes,
    bool? showSlideNumber,
  }) {
    final imgName = imageName ?? imagePath.split('/').last.split('.').first;
    return addSlide(
      SlideTitleAndPhoto(
        title: TextValue.uniform(title),
        subtitle: TextValue.uniform(subtitle),
        image: ImageReference(
          path: imagePath,
          name: imgName,
          description: imageDescription ?? imgName,
        ),
        author: TextValue.uniform(author),
      ),
      notes: notes,
      showSlideNumber: showSlideNumber,
    );
  }

  Slide addTitleAndPhotoAlt({
    required String title,
    required String imagePath,
    String? imageName,
    String? imageDescription,
    String? author,
    String? subtitle,
    TextValue? notes,
    bool? showSlideNumber,
  }) {
    final imgName = imageName ?? imagePath.split('/').last.split('.').first;
    return addSlide(
      SlideTitleAndPhotoAlt(
        title: TextValue.uniform(title),
        subtitle: TextValue.uniform(subtitle),
        author: TextValue.uniform(author),
        image: ImageReference(
          path: imagePath,
          name: imgName,
          description: imageDescription ?? imgName,
        ),
      ),
      notes: notes,
      showSlideNumber: showSlideNumber,
    );
  }

  Slide addTitleAndBullets({
    required String title,
    required List<String> bullets,
    String? author,
    String? subtitle,
    TextValue? notes,
    bool? showSlideNumber,
  }) {
    return addSlide(
      TitleAndBullets(
        title: TextValue.uniform(title),
        subtitle: TextValue.uniform(subtitle),
        bullets: bullets.map((e) => TextValue.uniform(e)).toList(),
        author: TextValue.uniform(author),
      ),
      notes: notes,
      showSlideNumber: showSlideNumber,
    );
  }

  Slide addBullets({
    required List<String> bullets,
    TextValue? notes,
    bool? showSlideNumber,
  }) {
    return addSlide(
      Bullets(
        bullets: bullets.map((e) => TextValue.uniform(e)).toList(),
      ),
      notes: notes,
      showSlideNumber: showSlideNumber,
    );
  }

  Slide addSlideTitleBulletsAndPhoto({
    required String title,
    required List<String> bullets,
    required String imagePath,
    String? imageName,
    String? imageDescription,
    TextValue? notes,
    String? author,
    String? subtitle,
    bool? showSlideNumber,
  }) {
    return addSlide(
      SlideTitleBulletsAndPhoto(
        title: TextValue.uniform(title),
        subtitle: TextValue.uniform(subtitle),
        author: TextValue.uniform(author),
        bullets: bullets.map((e) => TextValue.uniform(e)).toList(),
        image: ImageReference(
          path: imagePath,
          name: imageName ?? imagePath.split('/').last.split('.').first,
          description: imageDescription ??
              imageName ??
              imagePath.split('/').last.split('.').first,
        ),
      ),
      notes: notes,
      showSlideNumber: showSlideNumber,
    );
  }

  Future<List<int>?> save() async {
    final arc = Arc();

    // Copy template to temp path
    for (final entry in templates.entries) {
      // final utf16 = Uint16List.fromList(entry.value);
      final name = entry.key;
      if (name.startsWith('.') ||
          name.endsWith('.mustache') ||
          name.endsWith('.keep')) {
        continue;
      }
      if (name.contains('.png')) {
        // Base64 decode
        final bytes = base64Decode(entry.value);
        context.archive.addBinaryFile(name, bytes);
        continue;
      }
      final result = entry.value.trim();
      context.archive.addFile(entry.key, result);
    }

    final files = <String, String>{};

    arc.init(slides);

    for (var i = 0; i < slides.length; i++) {
      final item = slides[i];
      files['ppt/slides/_rels/slide${item.order}.xml.rels'] =
          item.renderRelTemplate(arc);
      files['ppt/slides/slide${item.order}.xml'] = item.renderTemplate(arc);
    }

    for (var i = 0; i < arc.notes.length; i++) {
      final note = arc.notes[i];
      final slide = slides[note.slideIndex];
      final rel = NotesRel(slideOrder: slide.order);
      files['ppt/notesSlides/_rels/notesSlide${note.order}.xml.rels'] =
          rel.toString();
      files['ppt/notesSlides/notesSlide${note.order}.xml'] =
          note.renderTemplate(arc);
    }

    final pres = Presentation(
      layout: layout,
      slides: slides,
    );

    files.addAll({
      'docProps/app.xml': App(slides: slides).toString(),
      'docProps/core.xml': Core().toString(),
      'ppt/presentation.xml': pres.toString(),
      'ppt/_rels/presentation.xml.rels': pres.createRel(),
      '[Content_Types].xml':
          ContentType(notes: arc.notes, slides: slides).toString(),
    });

    // Copy assets
    final futures = <Future>[];
    for (final item in arc.images) {
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
