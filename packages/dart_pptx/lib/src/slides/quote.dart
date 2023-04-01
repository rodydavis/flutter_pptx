import 'package:json_annotation/json_annotation.dart';

import '../classes/slide.dart';
import '../classes/text_value.dart';
import '../template/ppt/slides/quote.xml.mustache.dart';

part 'quote.g.dart';

@JsonSerializable(createFactory: false)
class SlideQuote extends Slide {
  SlideQuote({
    super.name = 'Quote',
    this.attribution,
    this.quote,
    super.slideNumber,
    super.speakerNotes,
  });

  TextValue? attribution;
  TextValueLine? quote;

  @override
  int get layoutId => 12;

  @override
  Map<String, dynamic> toJson() => _$SlideQuoteToJson(this);

  @override
  String get source => template;
}
