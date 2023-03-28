import 'package:json_annotation/json_annotation.dart';

import '../classes/slide.dart';
import '../classes/text_value.dart';
import '../template/ppt/slides/agenda.xml.mustache.dart';

part 'agenda.g.dart';

@JsonSerializable(createFactory: false)
class SlideAgenda extends Slide {
  SlideAgenda({
    super.name = 'Agenda',
    this.title,
    this.subtitle,
    this.topics,
    super.slideNumber,
    super.speakerNotes,
  });

  TextValue? title;
  TextValue? subtitle;
  TextValue? topics;

  @override
  int get layoutId => 9;

  @override
  Map<String, dynamic> toJson() => _$SlideAgendaToJson(this);

  @override
  String get source => template;
}
