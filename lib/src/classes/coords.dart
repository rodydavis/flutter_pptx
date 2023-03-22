import 'package:json_annotation/json_annotation.dart';

part 'coords.g.dart';

@JsonSerializable(createFactory: false)
class Coords {
  final num x;
  final num y;
  final num cx;
  final num cy;

  Coords({
    required this.x,
    required this.y,
    required this.cx,
    required this.cy,
  });

  Map<String, dynamic> toJson() => _$CoordsToJson(this);
}
