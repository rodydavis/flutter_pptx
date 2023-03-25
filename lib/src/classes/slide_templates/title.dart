import 'package:json_annotation/json_annotation.dart';
import 'package:mustache_template/mustache_template.dart';

import '../../template/ppt/slides/title.xml.mustache.dart';
import '../slide.dart';

part 'title.g.dart';

@JsonSerializable(createFactory: false)
class SlideTitle extends Slide {
  SlideTitle({
    required super.title,
    super.slideNumber,
    super.speakerNotes,
    this.author,
  });

  String? author;

  @override
  final int layoutId = 1;

  late int id1, id2, id3;

  @override
  int createIds(int offset) {
    int idx = offset;
    id1 = ++idx;
    id2 = ++idx;
    id3 = ++idx;
    return idx;
  }

  @override
  Map<String, dynamic> toJson() => _$SlideTitleToJson(this);

  @override
  String toString() {
    final source = Template(template);
    return source.renderString(toJson());
  }
}
