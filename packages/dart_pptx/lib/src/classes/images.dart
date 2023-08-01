// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

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

  @JsonKey(includeToJson: false)
  Uint8List? bytes;

  static ImageReference fromBytes(
    Uint8List bytes, {
    String name = 'image',
    String? description,
  }) {
    final base64 = base64Encode(bytes);
    return ImageReference(
      path: 'data:image/png;base64,$base64',
      name: '$name.png',
      description: description ?? name,
    );
  }

  bool get isNetwork => path.startsWith('http');
  bool get isMemory => path.startsWith('data:');
  bool get isAsset => path.startsWith('asset:');
  bool get isFile => path.startsWith('/') || path.startsWith('.');

  String get ext => isMemory ? 'png' : path.split('.').last;

  @override
  Map<String, dynamic> toJson() => _$ImageReferenceToJson(this);

  @override
  bool operator ==(covariant ImageReference other) {
    if (identical(this, other)) return true;
    return other.path == path &&
        other.name == name &&
        other.description == description;
  }

  @override
  int get hashCode => path.hashCode ^ name.hashCode ^ description.hashCode;
}
