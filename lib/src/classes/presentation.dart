import 'package:json_annotation/json_annotation.dart';
import 'package:mustache_template/mustache_template.dart';

import '../template/ppt/presentation.xml.mustache.dart';
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

  @override
  String toString() {
    final source = Template(template);
    return source.renderString(toJson());
  }
}
