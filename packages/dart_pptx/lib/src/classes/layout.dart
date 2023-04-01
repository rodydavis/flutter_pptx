import 'package:json_annotation/json_annotation.dart';

import '../util.dart';

part 'layout.g.dart';

@JsonSerializable(createFactory: false)
class Layout {
  int width;
  int height;
  String type;

  Layout({
    required this.width,
    required this.height,
    required this.type,
  });

  factory Layout.screen4x3() {
    return Layout(
      width: 9144000,
      height: 6858000,
      type: 'screen4x3',
    );
  }

  factory Layout.screen16x9() {
    return Layout(
      width: 9144000,
      height: 5143500,
      type: 'screen16x9',
    );
  }

  factory Layout.screen16x10() {
    return Layout(
      width: 9144000,
      height: 5715000,
      type: 'screen16x10',
    );
  }

  factory Layout.layoutWide() {
    return Layout(
      width: 12192000,
      height: 6858000,
      type: 'custom',
    );
  }

  factory Layout.custom(double width, double height) {
    return Layout(
      width: Util.pixleToPt(width).round(),
      height: Util.pixleToPt(height).round(),
      type: 'custom',
    );
  }

  Map<String, dynamic> toJson() => _$LayoutToJson(this);
}
