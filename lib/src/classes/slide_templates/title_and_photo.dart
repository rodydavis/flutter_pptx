import 'package:json_annotation/json_annotation.dart';
import 'package:mustache_template/mustache_template.dart';

import '../../template/ppt/slides/title.xml.mustache.dart';
import '../slide.dart';

part 'title_and_photo.g.dart';

@JsonSerializable(createFactory: false)
class SlideTitleAndPhoto extends Slide {
  SlideTitleAndPhoto({
    required super.title,
    required this.imageName,
    this.subtitle,
    super.speakerNotes,
    this.imageDescription,
    super.slideNumber,
    this.author,
  });

  String imageName;
  String? imageDescription;
  String? author;
  String? subtitle;

  @override
  final int layoutId = 2;

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
