import 'package:json_annotation/json_annotation.dart';

import '../classes/arc.dart';
import '../classes/images.dart';
import '../classes/media_slide.dart';
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

  @override
  Map<String, dynamic> toJson() => _$SlideTitleBulletsAndPhotoToJson(this);

  @override
  String get source => template;
}
