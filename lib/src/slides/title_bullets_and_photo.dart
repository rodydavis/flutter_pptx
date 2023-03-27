import 'package:json_annotation/json_annotation.dart';
import 'package:mustache_template/mustache_template.dart';

import '../classes/images.dart';
import '../classes/media_slide.dart';
import '../classes/slide.dart';
import '../classes/text_value.dart';
import '../template/ppt/slides/title_bullets_and_photo.xml.mustache.dart';

part 'title_bullets_and_photo.g.dart';

@JsonSerializable(createFactory: false)
class SlideTitleBulletsAndPhoto extends MediaSlide {
  SlideTitleBulletsAndPhoto({
    super.name = 'Title, Bullets and Photo',
    this.title,
    required this.image,
    required this.bullets,
    this.subtitle,
    super.speakerNotes,
    super.slideNumber,
    this.author,
  });

  List<TextValue> bullets;
  ImageReference image;
  TextValue? title;
  TextValue? author;
  TextValue? subtitle;

  @override
  List<ImageReference> get images => [image];

  @override
  int get layoutId => 6;

  int get imageId => hasNotes ? 3 : 2;

  late int id1, id2, id3, id4, id5;

  int get notesId => id5;

  @override
  int createIds(int offset) {
    int idx = offset;
    id1 = ++idx;
    id2 = ++idx;
    id3 = ++idx;
    id4 = ++idx;
    id5 = ++idx;
    return idx;
  }

  @override
  Map<String, dynamic> toJson() => _$SlideTitleBulletsAndPhotoToJson(this);

  @override
  String toString() {
    final source = Template(template, partialResolver: resolvePartials);
    return source.renderString(toJson());
  }
}
