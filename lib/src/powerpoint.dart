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
import 'slides/agenda.dart';
import 'slides/big_fact.dart';
import 'slides/blank.dart';
import 'slides/bullets.dart';
import 'slides/photo.dart';
import 'slides/photo_3_up.dart';
import 'slides/quote.dart';
import 'slides/section.dart';
import 'slides/statement.dart';
import 'slides/title.dart';
import 'slides/title_and_bullets.dart';
import 'slides/title_and_photo.dart';
import 'context.dart';
import 'slides/title_and_photo_alt.dart';
import 'slides/title_bullets_and_photo.dart';
import 'slides/title_only.dart';
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

  String? company;
  String? title;
  String? subject;
  String? author;
  String? revision;

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

  Slide addSection({
    required String section,
    TextValue? notes,
    bool? showSlideNumber,
  }) {
    return addSlide(
      SlideSection(
        section: TextValue.uniform(section),
      ),
      notes: notes,
      showSlideNumber: showSlideNumber,
    );
  }

  Slide addSlideTitleOnly({
    required String title,
    String? subtitle,
    TextValue? notes,
    bool? showSlideNumber,
  }) {
    return addSlide(
      SlideTitleOnly(
        title: TextValue.uniform(title),
        subtitle: TextValue.uniform(subtitle),
      ),
      notes: notes,
      showSlideNumber: showSlideNumber,
    );
  }

  Slide addSlideAgenda({
    required String title,
    String? subtitle,
    String? topics,
    TextValue? notes,
    bool? showSlideNumber,
  }) {
    return addSlide(
      SlideAgenda(
        title: TextValue.uniform(title),
        subtitle: TextValue.uniform(subtitle),
        topics: TextValue.uniform(topics),
      ),
      notes: notes,
      showSlideNumber: showSlideNumber,
    );
  }

  Slide addSlideStatement({
    required String statement,
    TextValue? notes,
    bool? showSlideNumber,
  }) {
    return addSlide(
      SlideStatement(
        statement: TextValue.uniform(statement),
      ),
      notes: notes,
      showSlideNumber: showSlideNumber,
    );
  }

  Slide addBigFact({
    required String fact,
    String? information,
    TextValue? notes,
    bool? showSlideNumber,
  }) {
    return addSlide(
      SlideBigFact(
        fact: TextValueLine(values: [TextItem(fact)]),
        information: TextValue.uniform(information),
      ),
      notes: notes,
      showSlideNumber: showSlideNumber,
    );
  }

  Slide addSlideQuote({
    required String quote,
    String? attribution,
    TextValue? notes,
    bool? showSlideNumber,
  }) {
    return addSlide(
      SlideQuote(
        quote: TextValueLine(values: [TextItem(quote)]),
        attribution: TextValue.uniform(attribution),
      ),
      notes: notes,
      showSlideNumber: showSlideNumber,
    );
  }

  Slide addSlidePhoto3Up({
    String? image1Path,
    String? image1Name,
    String? image1Description,
    String? image2Path,
    String? image2Name,
    String? image2Description,
    String? image3Path,
    String? image3Name,
    String? image3Description,
    TextValue? notes,
    bool? showSlideNumber,
  }) {
    return addSlide(
      SlidePhoto3Up(
        image1: image1Path == null
            ? null
            : ImageReference(
                path: image1Path,
                name: image1Name ?? image1Path.split('/').last.split('.').first,
                description: image1Description ??
                    image1Name ??
                    image1Path.split('/').last.split('.').first,
              ),
        image2: image2Path == null
            ? null
            : ImageReference(
                path: image2Path,
                name: image2Name ?? image2Path.split('/').last.split('.').first,
                description: image2Description ??
                    image2Name ??
                    image2Path.split('/').last.split('.').first,
              ),
        image3: image3Path == null
            ? null
            : ImageReference(
                path: image3Path,
                name: image3Name ?? image3Path.split('/').last.split('.').first,
                description: image3Description ??
                    image3Name ??
                    image3Path.split('/').last.split('.').first,
              ),
      ),
      notes: notes,
      showSlideNumber: showSlideNumber,
    );
  }

  Slide addSlidePhoto({
    required String imagePath,
    String? imageName,
    String? imageDescription,
    TextValue? notes,
    bool? showSlideNumber,
  }) {
    return addSlide(
      SlidePhoto(
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

  Slide addSlideBlank({
    TextValue? notes,
    bool? showSlideNumber,
  }) {
    return addSlide(
      SlideBlank(),
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
      'docProps/app.xml': App(
        slides: slides,
        company: company,
      ).toString(),
      'docProps/core.xml': Core(
        title: title,
        subject: subject,
        author: author,
        revision: revision,
      ).toString(),
      'ppt/presentation.xml': pres.toString(),
      'ppt/_rels/presentation.xml.rels': pres.createRel(),
      '[Content_Types].xml': ContentType(
        notes: arc.notes,
        slides: slides,
        comments: arc.comments,
      ).toString(),
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
