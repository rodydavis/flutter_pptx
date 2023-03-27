import 'package:json_annotation/json_annotation.dart';
import 'package:mustache_template/mustache_template.dart';

import '../classes/images.dart';
import '../classes/media_slide.dart';
import '../template/ppt/slides/title_and_photo.xml.mustache.dart';

part 'title_and_photo.g.dart';

@JsonSerializable(createFactory: false)
class SlideTitleAndPhoto extends MediaSlide {
  SlideTitleAndPhoto({
    required super.title,
    required this.image,
    this.subtitle,
    super.speakerNotes,
    super.slideNumber,
    this.author,
  });

  ImageReference image;
  String? author;
  String? subtitle;

  @override
  List<ImageReference> get images => [image];

  @override
  final int layoutId = 2;

  int get imageId => hasNotes ? 3 : 2;

  late int id1, id2, id3, id4, id5;

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
  Map<String, dynamic> toJson() => _$SlideTitleAndPhotoToJson(this);

  @override
  String toString() {
    final source = Template(template);
    return source.renderString(toJson());
  }
}
