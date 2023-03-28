import 'package:json_annotation/json_annotation.dart';

import '../classes/images.dart';
import '../classes/slide.dart';
import '../template/ppt/slides/photo.xml.mustache.dart';

part 'photo.g.dart';

@JsonSerializable(createFactory: false)
class SlidePhoto extends Slide {
  SlidePhoto({
    super.name = 'Photo',
    this.image,
    super.speakerNotes,
    super.slideNumber,
  });

  ImageReference? image;

  @override
  int get layoutId => 14;

  @override
  Map<int, ImageReference?> get imageRefs => {...super.imageRefs, 1: image};

  @override
  Map<String, dynamic> toJson() => _$SlidePhotoToJson(this);

  @override
  String get source => template;
}
