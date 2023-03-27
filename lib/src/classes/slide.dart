// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'base.dart';

part 'slide.g.dart';

@JsonSerializable(createFactory: false)
class Slide extends Base {
  String title;
  bool slideNumber;
  String speakerNotes;
  int layoutId = -1;

  Slide({
    required this.title,
    this.speakerNotes = '',
    this.slideNumber = false,
  });

  int createIds(int offset) {
    return offset;
  }

  bool get hasNotes => speakerNotes.trim().isNotEmpty;

  @override
  Map<String, dynamic> toJson() => _$SlideToJson(this);
}
