import 'package:json_annotation/json_annotation.dart';

import '../classes/arc.dart';
import '../classes/images.dart';
import '../classes/media_slide.dart';
import '../classes/text_value.dart';
import '../template/ppt/slides/title_and_photo_alt.xml.mustache.dart';

part 'title_and_photo_alt.g.dart';

@JsonSerializable(createFactory: false)
class SlideTitleAndPhotoAlt extends MediaSlide {
  SlideTitleAndPhotoAlt({
    super.name = 'Title and Photo Alt',
    required this.image,
    this.title,
    this.subtitle,
    super.speakerNotes,
    super.slideNumber,
    this.author,
  });

  ImageReference image;
  TextValue? title;
  TextValue? author;
  TextValue? subtitle;

  @override
  List<ImageReference> get images => [image];

  @override
  int get layoutId => 3;

  @override
  Map<String, dynamic> toJson() => _$SlideTitleAndPhotoAltToJson(this);

  @override
  String get source => template;
}
