// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:mustache_template/mustache_template.dart';

import 'base.dart';
import 'speaker_notes.dart';
import 'text_value.dart';

part 'slide.g.dart';

@JsonSerializable(createFactory: false)
class Slide extends Base {
  String name;
  bool slideNumber;
  TextValue? speakerNotes;
  int layoutId = -1;

  Slide({
    required this.name,
    this.speakerNotes,
    this.slideNumber = false,
  });

  int createIds(int offset) {
    return offset;
  }

  bool get hasNotes => speakerNotes != null;

  @override
  Map<String, dynamic> toJson() => _$SlideToJson(this);
}

Template? resolvePartials(String value) {
  if (value.isEmpty) return null;
  if (value == 'speaker-notes') return slideNotesTemplate;
  if (value == 'text-value') return textValueTemplate;
  return null;
}
