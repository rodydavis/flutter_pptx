import 'classes.dart';
import 'powerpoint.dart';

import 'slides/agenda.dart';
import 'slides/big_fact.dart';
import 'slides/blank.dart';
import 'slides/bullets.dart';
import 'slides/photo_3_up.dart';
import 'slides/photo.dart';
import 'slides/quote.dart';
import 'slides/section.dart';
import 'slides/statement.dart';
import 'slides/title_and_bullets.dart';
import 'slides/title_and_photo_alt.dart';
import 'slides/title_and_photo.dart';
import 'slides/title_bullets_and_photo.dart';
import 'slides/title_only.dart';
import 'slides/title.dart';

export 'slides/agenda.dart';
export 'slides/big_fact.dart';
export 'slides/blank.dart';
export 'slides/bullets.dart';
export 'slides/photo_3_up.dart';
export 'slides/photo.dart';
export 'slides/quote.dart';
export 'slides/section.dart';
export 'slides/statement.dart';
export 'slides/title_and_bullets.dart';
export 'slides/title_and_photo_alt.dart';
export 'slides/title_and_photo.dart';
export 'slides/title_bullets_and_photo.dart';
export 'slides/title_only.dart';
export 'slides/title.dart';

extension SlideTemplates on PowerPoint {
  Slide addTitleSlide({
    TextValue? title,
    TextValue? author,
  }) =>
      addSlide(SlideTitle(
        title: title,
        author: author,
      ));

  Slide addTitleAndPhotoSlide({
    TextValue? title,
    ImageReference? image,
    TextValue? author,
    TextValue? subtitle,
  }) =>
      addSlide(SlideTitleAndPhoto(
        title: title,
        subtitle: subtitle,
        image: image,
        author: author,
      ));

  Slide addTitleAndPhotoAltSlide({
    ImageReference? image,
    TextValue? title,
    TextValue? subtitle,
  }) {
    return addSlide(SlideTitleAndPhotoAlt(
      title: title,
      subtitle: subtitle,
      image: image,
    ));
  }

  Slide addTitleAndBulletsSlide({
    TextValue? title,
    List<TextValue> bullets = const [],
    TextValue? subtitle,
  }) =>
      addSlide(SlideTitleAndBullets(
        bullets: bullets,
        title: title,
        subtitle: subtitle,
      ));

  Slide addBulletsSlide({
    List<TextValue> bullets = const [],
  }) =>
      addSlide(SlideBullets(
        bullets: bullets,
      ));

  Slide addTitleBulletsAndPhotoSlide({
    TextValue? title,
    List<TextValue> bullets = const [],
    ImageReference? image,
    TextValue? subtitle,
  }) =>
      addSlide(SlideTitleBulletsAndPhoto(
        title: title,
        subtitle: subtitle,
        bullets: bullets,
        image: image,
      ));

  Slide addSectionSlide({
    TextValue? section,
  }) =>
      addSlide(SlideSection(
        section: section,
      ));

  Slide addTitleOnlySlide({
    TextValue? title,
    TextValue? subtitle,
  }) =>
      addSlide(SlideTitleOnly(
        title: title,
        subtitle: subtitle,
      ));

  Slide addAgendaSlide({
    TextValue? title,
    TextValue? subtitle,
    TextValue? topics,
  }) =>
      addSlide(SlideAgenda(
        title: title,
        subtitle: subtitle,
        topics: topics,
      ));

  Slide addStatementSlide({
    TextValue? statement,
  }) =>
      addSlide(SlideStatement(
        statement: statement,
      ));

  Slide addBigFactSlide({
    TextValueLine? fact,
    TextValue? information,
  }) =>
      addSlide(SlideBigFact(
        fact: fact,
        information: information,
      ));

  Slide addQuoteSlide({
    TextValueLine? quote,
    TextValue? attribution,
  }) =>
      addSlide(SlideQuote(
        quote: quote,
        attribution: attribution,
      ));

  Slide addPhoto3UpSlide({
    ImageReference? image1,
    ImageReference? image2,
    ImageReference? image3,
  }) =>
      addSlide(SlidePhoto3Up(
        image1: image1,
        image2: image2,
        image3: image3,
      ));

  Slide addPhotoSlide({
    ImageReference? image,
  }) =>
      addSlide(SlidePhoto(
        image: image,
      ));

  Slide addBlankSlide() {
    return addSlide(
      SlideBlank(),
    );
  }
}
