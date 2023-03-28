import 'package:json_annotation/json_annotation.dart';
import 'package:mustache_template/mustache_template.dart';

import '../template/[Content_Types].xml.mustache.dart';
import 'comments.dart';
import 'notes.dart';
import 'slide.dart';

part 'content_type.g.dart';

@JsonSerializable(createFactory: false)
class ContentType {
  List<Slide> slides;
  List<Notes> notes;
  List<Comments> comments;

  ContentType({
    required this.notes,
    required this.slides,
    required this.comments,
  });

  Map<String, dynamic> toJson() => _$ContentTypeToJson(this);

  @override
  String toString() {
    final source = Template(template);
    return source.renderString(toJson());
  }
}
