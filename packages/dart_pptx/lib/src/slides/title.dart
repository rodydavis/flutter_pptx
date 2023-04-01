import 'package:json_annotation/json_annotation.dart';

import '../classes/slide.dart';
import '../classes/text_value.dart';
import '../template/ppt/slides/title.xml.mustache.dart';

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
  int get layoutId => 1;

  @override
  Map<String, dynamic> toJson() => _$SlideTitleToJson(this);

  @override
  String get source => template;
}
