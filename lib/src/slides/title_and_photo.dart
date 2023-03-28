import 'package:json_annotation/json_annotation.dart';

import '../classes/arc.dart';
import '../classes/images.dart';
import '../classes/media_slide.dart';
import '../classes/text_value.dart';
import '../template/ppt/slides/title_and_photo.xml.mustache.dart';

part 'title_and_photo.g.dart';

@JsonSerializable(createFactory: false)
class SlideTitleAndPhoto extends MediaSlide {
  SlideTitleAndPhoto({
    super.name = 'Title and Photo',
    this.title,
    required this.image,
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
  int get layoutId => 2;

  int imageId = -1;

 @override
  Map<String, dynamic> generateLocalIds(Arc arc) {
    final data = super.generateLocalIds(arc);
    final related = arc.getImagesForSlide(this);
    if (related.isNotEmpty) {
      imageId = related.first.order;
    }
    return {
      ...data,
      'imageId': imageId,
    };
  }

  @override
  Map<String, dynamic> toJson() => _$SlideTitleAndPhotoToJson(this);

  @override
  String get source => template;
}
