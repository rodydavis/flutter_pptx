// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'base.dart';

part 'images.g.dart';

@JsonSerializable(createFactory: false)
class Images extends Base {
  String path;

  Images({required this.path});

  @override
  Map<String, dynamic> toJson() => _$ImagesToJson(this);
}
