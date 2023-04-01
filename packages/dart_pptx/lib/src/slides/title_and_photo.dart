import 'package:json_annotation/json_annotation.dart';

import '../classes/images.dart';
import '../classes/slide.dart';
import '../classes/text_value.dart';
import '../template/ppt/slides/title_and_photo.xml.mustache.dart';

part 'title_and_photo.g.dart';

@JsonSerializable(createFactory: false)
class SlideTitleAndPhoto extends Slide {
  SlideTitleAndPhoto({
    super.name = 'Title and Photo',
    this.title,
    this.image,
    this.subtitle,
    super.speakerNotes,
    super.slideNumber,
    this.author,
  });

  ImageReference? image;
  TextValue? title;
  TextValue? author;
  TextValue? subtitle;

  @override
  int get layoutId => 2;

  @override
  Map<int, ImageReference?> get imageRefs => {...super.imageRefs, 1: image};

  @override
  Map<String, dynamic> toJson() => _$SlideTitleAndPhotoToJson(this);

  @override
  String get source => template;
}
