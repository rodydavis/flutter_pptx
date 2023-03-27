// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:mustache_template/mustache_template.dart';

import '../template/ppt/slides/_rels/slide.xml.rels.mustache.dart';
import 'images.dart';
import 'notes.dart';

part 'slide_rel.g.dart';

@JsonSerializable(createFactory: false)
class SlideRel {
  int layoutId;
  List<Notes> notes;
  List<ImageReference> images;

  SlideRel({
    required this.layoutId,
    required this.notes,
    required this.images,
  });

  Map<String, dynamic> toJson() => _$SlideRelToJson(this);

  @override
  String toString() {
    var localRId = 1;
    for (var item in notes) {
      item.localRId = ++localRId;
    }
    for (var item in images) {
      item.localRId = ++localRId;
    }
    final source = Template(template);
    return source.renderString(toJson());
  }
}
