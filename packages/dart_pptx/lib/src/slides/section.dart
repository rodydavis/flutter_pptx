import 'package:json_annotation/json_annotation.dart';

import '../classes/slide.dart';
import '../classes/text_value.dart';
import '../template/ppt/slides/section.xml.mustache.dart';

part 'section.g.dart';

@JsonSerializable(createFactory: false)
class SlideSection extends Slide {
  SlideSection({
    super.name = 'Section',
    this.section,
    super.slideNumber,
    super.speakerNotes,
  });

  TextValue? section;

  @override
  int get layoutId => 7;

  @override
  Map<String, dynamic> toJson() => _$SlideSectionToJson(this);

  @override
  String get source => template;
}
