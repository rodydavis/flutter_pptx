// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'notes.g.dart';

@JsonSerializable(createFactory: false)
class Notes {
  String notes;
  late int index;
  late bool isLast;
  late int rId;
  late int id;
  int get order => index + 1;

  Notes({required this.notes});

  Map<String, dynamic> toJson() => _$NotesToJson(this);
}
