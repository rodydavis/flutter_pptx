import 'package:json_annotation/json_annotation.dart';

import '../classes/slide.dart';
import '../classes/text_value.dart';
import '../template/ppt/slides/title_only.xml.mustache.dart';

part 'title_only.g.dart';

@JsonSerializable(createFactory: false)
class SlideTitleOnly extends Slide {
  SlideTitleOnly({
    super.name = 'Title Only',
    this.title,
    this.subtitle,
    super.slideNumber,
    super.speakerNotes,
  });

  TextValue? title;
  TextValue? subtitle;

  @override
  int get layoutId => 8;

  @override
  Map<String, dynamic> toJson() => _$SlideTitleOnlyToJson(this);

  @override
  String get source => template;
}
