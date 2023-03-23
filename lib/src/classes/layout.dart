import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';

import '../util.dart';

part 'layout.g.dart';

enum LayoutType {
  screen4x3,
  screen16x9,
  screen16x10,
  custom,
}

@JsonSerializable(createFactory: false)
class Layout {
  final int width;
  final int height;
  final LayoutType type;

  Layout({
    required this.width,
    required this.height,
    required this.type,
  });

  factory Layout.screen4x3() {
    return Layout(
      width: 9144000,
      height: 6858000,
      type: LayoutType.screen4x3,
    );
  }

  factory Layout.screen16x9() {
    return Layout(
      width: 9144000,
      height: 5143500,
      type: LayoutType.screen16x9,
    );
  }

  factory Layout.screen16x10() {
    return Layout(
      width: 9144000,
      height: 5715000,
      type: LayoutType.screen16x10,
    );
  }

  factory Layout.layoutWide() {
    return Layout(
      width: 12192000,
      height: 6858000,
      type: LayoutType.custom,
    );
  }

  factory Layout.fromType(LayoutType type) {
    switch (type) {
      case LayoutType.screen4x3:
        return Layout.screen4x3();
      case LayoutType.screen16x9:
        return Layout.screen16x9();
      case LayoutType.screen16x10:
        return Layout.screen16x10();
      case LayoutType.custom:
        return Layout.layoutWide();
    }
  }

  factory Layout.fromSize(Size size) {
    return Layout(
      width: Util.pixleToPt(size.width).round(),
      height: Util.pixleToPt(size.height).round(),
      type: LayoutType.custom,
    );
  }

  Map<String, dynamic> toJson() => _$LayoutToJson(this);
}
