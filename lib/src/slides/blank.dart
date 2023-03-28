import 'package:json_annotation/json_annotation.dart';

import '../classes/slide.dart';
import '../template/ppt/slides/blank.xml.mustache.dart';

part 'blank.g.dart';

@JsonSerializable(createFactory: false)
class SlideBlank extends Slide {
  SlideBlank({
    super.name = 'Blank',
    super.speakerNotes,
    super.slideNumber,
  });

  @override
  int get layoutId => 15;

  @override
  Map<String, dynamic> toJson() => _$SlideBlankToJson(this);

  @override
  String get source => template;
}
