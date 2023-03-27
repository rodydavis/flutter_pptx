import 'package:json_annotation/json_annotation.dart';
import 'package:mustache_template/mustache_template.dart';

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

  late int id1, id2;

  int get notesId => id2;

  @override
  int get layoutId => 5;

  @override
  int createIds(int offset) {
    int idx = offset;
    id1 = ++idx;
    id2 = ++idx;
    return idx;
  }

  @override
  Map<String, dynamic> toJson() => _$BulletsToJson(this);

  @override
  String toString() {
    final source = Template(template, partialResolver: resolvePartials);
    return source.renderString(toJson());
  }
}
