import 'package:json_annotation/json_annotation.dart';
import 'package:mustache_template/mustache_template.dart';

import '../template/ppt/presentation.xml.mustache.dart';
import '../template/ppt/_rels/presentation.xml.rels.mustache.dart' as rel;
import 'layout.dart';
import 'slide.dart';

part 'presentation.g.dart';

@JsonSerializable(createFactory: false)
class Presentation {
  Layout layout;
  List<Slide> slides;

  Presentation({
    required this.layout,
    required this.slides,
  });

  Map<String, dynamic> toJson() => _$PresentationToJson(this);

  String createRel() {
    final source = Template(rel.template);
    return source.renderString(toJson());
  }

  @override
  String toString() {
    final source = Template(template);
    return source.renderString(toJson());
  }
}
