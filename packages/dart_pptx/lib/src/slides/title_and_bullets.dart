import 'package:json_annotation/json_annotation.dart';

import '../classes/text_value.dart';
import '../template/ppt/slides/title_and_bullets.xml.mustache.dart';
import 'bullets.dart';

part 'title_and_bullets.g.dart';

@JsonSerializable(createFactory: false)
class SlideTitleAndBullets extends SlideBullets {
  SlideTitleAndBullets({
    required super.bullets,
    super.name = 'Title and Bullets',
    this.title,
    this.subtitle,
    super.speakerNotes,
    super.slideNumber,
  });

  TextValue? title;
  TextValue? subtitle;

  @override
  int get layoutId => 4;

  @override
  Map<String, dynamic> toJson() => _$SlideTitleAndBulletsToJson(this);

  @override
  String get source => template;
}
