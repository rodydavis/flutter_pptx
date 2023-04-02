import 'package:json_annotation/json_annotation.dart';

import '../classes/images.dart';
import '../classes/slide.dart';
import '../classes/text_value.dart';
import '../template/ppt/slides/title_bullets_and_photo.xml.mustache.dart';

part 'title_bullets_and_photo.g.dart';

@JsonSerializable(createFactory: false)
class SlideTitleBulletsAndPhoto extends Slide {
  SlideTitleBulletsAndPhoto({
    super.name = 'Title, Bullets and Photo',
    this.title,
    this.image,
    this.bullets = const [],
    this.subtitle,
    super.speakerNotes,
    super.slideNumber,
  });

  List<TextValue> bullets;
  ImageReference? image;
  TextValue? title;
  TextValue? subtitle;

  @override
  int get layoutId => 6;

  @override
  Map<int, ImageReference?> get imageRefs => {...super.imageRefs, 1: image};

  @override
  Map<String, dynamic> toJson() => _$SlideTitleBulletsAndPhotoToJson(this);

  @override
  String get source => template;
}
