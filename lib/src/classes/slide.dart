// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'slide.g.dart';

@JsonSerializable(createFactory: false)
class Slide {
  String title;
  late int index;
  late bool isLast;
  late int rId;
  late int id;
  int get order => index + 1;

  Slide({required this.title});

  Map<String, dynamic> toJson() => _$SlideToJson(this);
}
