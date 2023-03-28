// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'base.dart';

part 'images.g.dart';

@JsonSerializable(createFactory: false)
class ImageReference extends Base {
  String path;
  String name;
  String? description;

  ImageReference({
    required this.path,
    required this.name,
    this.description,
  });

  bool get isNetwork => path.startsWith('http');
  bool get isMemory => path.startsWith('data:');
  bool get isAsset => path.startsWith('asset:');
  bool get isFile => path.startsWith('/') || path.startsWith('.');

  String get ext => isMemory ? 'png' : path.split('.').last;

  @override
  Map<String, dynamic> toJson() => _$ImageReferenceToJson(this);
}
