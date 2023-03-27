// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'base.g.dart';

@JsonSerializable(createFactory: false)
class Base {
  int index = -1;
  bool isLast = false;
  int rId = -1;
  int id = -1;
  int get order => index + 1;
  int? localRId;

  Map<String, dynamic> toJson() => _$BaseToJson(this);
}
