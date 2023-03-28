import 'package:json_annotation/json_annotation.dart';

import '../classes/slide.dart';
import '../classes/text_value.dart';
import '../template/ppt/slides/big_fact.xml.mustache.dart';

part 'big_fact.g.dart';

@JsonSerializable(createFactory: false)
class SlideBigFact extends Slide {
  SlideBigFact({
    super.name = 'Big Fact',
    this.fact,
    this.information,
    super.slideNumber,
    super.speakerNotes,
  });

  TextValue? information;
  TextValueLine? fact;

  @override
  int get layoutId => 11;

  @override
  Map<String, dynamic> toJson() => _$SlideBigFactToJson(this);

  @override
  String get source => template;
}
