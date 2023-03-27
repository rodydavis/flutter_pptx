import 'package:json_annotation/json_annotation.dart';
import 'package:mustache_template/mustache_template.dart';

import '../classes/slide.dart';
import '../classes/text_value.dart';
import '../template/ppt/slides/title_and_bullets.xml.mustache.dart';
import 'bullets.dart';

part 'title_and_bullets.g.dart';

@JsonSerializable(createFactory: false)
class TitleAndBullets extends Bullets {
  TitleAndBullets({
    required super.bullets,
    super.name = 'Title and Bullets',
    this.title,
    this.subtitle,
    super.speakerNotes,
    super.slideNumber,
    this.author,
  });

  TextValue? title;
  TextValue? author;
  TextValue? subtitle;

  @override
  int get layoutId => 4;

  @override
  @override
  late int id1, id2, id3, id4;

  @override
  int get notesId => id4;

  @override
  int createIds(int offset) {
    int idx = offset;
    id1 = ++idx;
    id2 = ++idx;
    id3 = ++idx;
    id4 = ++idx;
    return idx;
  }

  @override
  Map<String, dynamic> toJson() => _$TitleAndBulletsToJson(this);

  @override
  String toString() {
    final source = Template(template, partialResolver: resolvePartials);
    return source.renderString(toJson());
  }
}
