import 'package:json_annotation/json_annotation.dart';
import 'package:mustache_template/mustache_template.dart';
import '../classes/text_value.dart';
import '../template/ppt/slides/title.xml.mustache.dart';

import '../classes/slide.dart';

part 'title.g.dart';

@JsonSerializable(createFactory: false)
class SlideTitle extends Slide {
  SlideTitle({
    super.name = 'Title',
    this.title,
    super.slideNumber,
    super.speakerNotes,
    this.author,
  });

  TextValue? title;
  TextValue? author;

  @override
  final int layoutId = 1;

  late int id1, id2, id3;

  int get notesId => id3;

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
    final source = Template(template, partialResolver: resolvePartials);
    return source.renderString(toJson());
  }
}
