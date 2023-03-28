import 'package:json_annotation/json_annotation.dart';

import '../classes/slide.dart';
import '../classes/text_value.dart';
import '../template/ppt/slides/statement.xml.mustache.dart';

part 'statement.g.dart';

@JsonSerializable(createFactory: false)
class SlideStatement extends Slide {
  SlideStatement({
    super.name = 'Statement',
    this.statement,
    super.slideNumber,
    super.speakerNotes,
  });

  TextValue? statement;

  @override
  int get layoutId => 10;

  @override
  Map<String, dynamic> toJson() => _$SlideStatementToJson(this);

  @override
  String get source => template;
}
