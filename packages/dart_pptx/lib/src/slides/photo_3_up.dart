import 'package:json_annotation/json_annotation.dart';

import '../classes/images.dart';
import '../classes/slide.dart';
import '../template/ppt/slides/photo_3_up.xml.mustache.dart';

part 'photo_3_up.g.dart';

@JsonSerializable(createFactory: false)
class SlidePhoto3Up extends Slide {
  SlidePhoto3Up({
    super.name = 'Photo 3 Up',
    this.image1,
    this.image2,
    this.image3,
    super.speakerNotes,
    super.slideNumber,
  });

  ImageReference? image1, image2, image3;

  @override
  int get layoutId => 13;

  @override
  Map<int, ImageReference?> get imageRefs => {
        ...super.imageRefs,
        1: image1,
        2: image2,
        3: image3,
      };

  @override
  Map<String, dynamic> toJson() => _$SlidePhoto3UpToJson(this);

  @override
  String get source => template;
}
