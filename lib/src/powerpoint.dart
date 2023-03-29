import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

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
import 'markdown.dart';
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

  Slide addTitleSlide({
    TextValue? title,
    TextValue? author,
  }) =>
      addSlide(
        SlideTitle(
          title: title,
          author: author,
        ),
        showSlideNumber: showSlideNumber,
      );

  Slide addTitleAndPhotoSlide({
    TextValue? title,
    ImageReference? image,
    TextValue? author,
    TextValue? subtitle,
  }) =>
      addSlide(
        SlideTitleAndPhoto(
          title: title,
          subtitle: subtitle,
          image: image,
          author: author,
        ),
        showSlideNumber: showSlideNumber,
      );

  Slide addTitleAndPhotoAltSlide({
    ImageReference? image,
    TextValue? title,
    TextValue? author,
    TextValue? subtitle,
  }) {
    return addSlide(
      SlideTitleAndPhotoAlt(
        title: title,
        subtitle: subtitle,
        author: author,
        image: image,
      ),
      showSlideNumber: showSlideNumber,
    );
  }

  Slide addTitleAndBulletsSlide({
    TextValue? title,
    List<TextValue> bullets = const [],
    TextValue? author,
    TextValue? subtitle,
  }) =>
      addSlide(
        TitleAndBullets(
          bullets: bullets,
          title: title,
          subtitle: subtitle,
          author: author,
        ),
        showSlideNumber: showSlideNumber,
      );

  Slide addBulletsSlide({
    List<TextValue> bullets = const [],
  }) =>
      addSlide(
        Bullets(
          bullets: bullets,
        ),
        showSlideNumber: showSlideNumber,
      );

  Slide addTitleBulletsAndPhotoSlide({
    TextValue? title,
    List<TextValue> bullets = const [],
    ImageReference? image,
    TextValue? notes,
    TextValue? author,
    TextValue? subtitle,
    bool? showSlideNumber,
  }) =>
      addSlide(
        SlideTitleBulletsAndPhoto(
          title: title,
          subtitle: subtitle,
          author: author,
          bullets: bullets,
          image: image,
        ),
        showSlideNumber: showSlideNumber,
      );

  Slide addSectionSlide({
    TextValue? section,
  }) =>
      addSlide(
        SlideSection(
          section: section,
        ),
        showSlideNumber: showSlideNumber,
      );

  Slide addTitleOnlySlide({
    TextValue? title,
    TextValue? subtitle,
  }) =>
      addSlide(
        SlideTitleOnly(
          title: title,
          subtitle: subtitle,
        ),
        showSlideNumber: showSlideNumber,
      );

  Slide addAgendaSlide({
    TextValue? title,
    TextValue? subtitle,
    TextValue? topics,
  }) =>
      addSlide(
        SlideAgenda(
          title: title,
          subtitle: subtitle,
          topics: topics,
        ),
        showSlideNumber: showSlideNumber,
      );

  Slide addStatementSlide({
    TextValue? statement,
  }) =>
      addSlide(
        SlideStatement(
          statement: statement,
        ),
        showSlideNumber: showSlideNumber,
      );

  Slide addBigFactSlide({
    TextValueLine? fact,
    TextValue? information,
  }) =>
      addSlide(
        SlideBigFact(
          fact: fact,
          information: information,
        ),
        showSlideNumber: showSlideNumber,
      );

  Slide addQuoteSlide({
    TextValueLine? quote,
    TextValue? attribution,
  }) =>
      addSlide(
        SlideQuote(
          quote: quote,
          attribution: attribution,
        ),
        showSlideNumber: showSlideNumber,
      );

  Slide addPhoto3UpSlide({
    ImageReference? image1,
    ImageReference? image2,
    ImageReference? image3,
  }) =>
      addSlide(
        SlidePhoto3Up(
          image1: image1,
          image2: image2,
          image3: image3,
        ),
        showSlideNumber: showSlideNumber,
      );

  Slide addPhotoSlide({
    ImageReference? image,
  }) =>
      addSlide(
        SlidePhoto(
          image: image,
        ),
        showSlideNumber: showSlideNumber,
      );

  Future<Slide> addWidgetSlide(
    Widget child, {
    Duration delay = const Duration(seconds: 1),
    double? pixelRatio,
    BuildContext? context,
    Size? targetSize,
  }) async {
    final bytes = await this.context.screenshotController.captureFromWidget(
          child,
          delay: delay,
          pixelRatio: pixelRatio,
          context: context,
          targetSize: targetSize ?? layout.size,
        );
    final image = ImageReference.fromBytes(
      bytes,
      name: 'widget',
      description: 'image created from a widget',
    );
    return addSlide(
      SlideBlank()..background.image = image,
      showSlideNumber: showSlideNumber,
    );
  }

  Slide addBlankSlide() {
    return addSlide(
      SlideBlank(),
      showSlideNumber: showSlideNumber,
    );
  }

  List<Slide> addSlidesFromMarkdown(String markdown) {
    final items = createSlidesFromMarkdown(markdown);
    slides.addAll(items);
    return items;
  }

  Future<Uint8List?> save() async {
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
    final data = context.archive.toBytes();
    if (data == null) return null;
    return Uint8List.fromList(data);
  }
}
