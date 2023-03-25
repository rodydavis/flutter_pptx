// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:mustache_template/mustache_template.dart';

import '../template/ppt/notesSlides/notesSlide.xml.mustache.dart';
import 'base.dart';
import 'slide.dart';

part 'notes.g.dart';

@JsonSerializable(createFactory: false)
class Notes extends Base {
  String notes;

  late int id1, id2;

  int slideIndex;

  int createIds(int offset) {
    int idx = offset;
    id1 = ++idx;
    id2 = ++idx;
    return idx;
  }

  Notes({
    required this.slideIndex,
    required this.notes,
  });

  @override
  Map<String, dynamic> toJson() => _$NotesToJson(this);

  @override
  String toString() {
    final source = Template(template);
    return source.renderString(toJson());
  }
}
