import 'package:json_annotation/json_annotation.dart';

import '../classes/slide.dart';
import '../classes/text_value.dart';
import '../template/ppt/slides/bullets.xml.mustache.dart';

part 'bullets.g.dart';

@JsonSerializable(createFactory: false)
class Bullets extends Slide {
  Bullets({
    required this.bullets,
    super.name = 'Bullets',
    super.speakerNotes,
    super.slideNumber,
  });

  List<TextValue> bullets;

  @override
  int get layoutId => 5;

  @override
  Map<String, dynamic> toJson() => _$BulletsToJson(this);

  @override
  String get source => template;
}
