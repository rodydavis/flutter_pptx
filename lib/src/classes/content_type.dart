import 'package:json_annotation/json_annotation.dart';
import 'package:mustache_template/mustache_template.dart';

import '../template/[Content_Types].xml.mustache.dart';
import 'notes.dart';
import 'slide.dart';

part 'content_type.g.dart';

@JsonSerializable(createFactory: false)
class ContentType {
  List<Slide> slides;
  List<Notes> notes;

  ContentType({
    this.notes = const [],
    this.slides = const [],
  });

  Map<String, dynamic> toJson() => _$ContentTypeToJson(this);

  @override
  String toString() {
    final source = Template(template);
    return source.renderString(toJson());
  }
}
