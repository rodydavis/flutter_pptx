// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:mustache_template/mustache_template.dart';

import '../template/ppt/notesSlides/_rels/noteSlide.xml.rels.mustache.dart';

part 'notes_rel.g.dart';

@JsonSerializable(createFactory: false)
class NotesRel {
  int slideOrder;

  NotesRel({
    required this.slideOrder,
  });

  Map<String, dynamic> toJson() => _$NotesRelToJson(this);

  @override
  String toString() {
    final source = Template(template);
    return source.renderString(toJson());
  }
}
