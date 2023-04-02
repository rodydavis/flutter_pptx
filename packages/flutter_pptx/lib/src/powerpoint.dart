import 'dart:html';

import 'package:dart_pptx/dart_pptx.dart' show PowerPoint;
import 'package:flutter_pptx/flutter_pptx.dart';
// ignore: implementation_imports
import 'package:dart_pptx/src/util.dart';
import 'package:flutter/material.dart';

class FlutterPowerPoint extends PowerPoint {
  @override
  // ignore: overridden_fields
  var context = FlutterPresentationContext();

  Future<Slide> addWidgetSlide(
    Widget Function(Size size) builder, {
    Duration delay = const Duration(seconds: 1),
    double? pixelRatio,
    BuildContext? context,
    Size? targetSize,
  }) async {
    final image = await imageFromWidget(
      this,
      builder,
      delay: delay,
      pixelRatio: pixelRatio,
      context: context,
      targetSize: targetSize,
    );
    return addSlide(SlideBlank()..background.image = image);
  }
}

Future<ImageReference> imageFromWidget(
  FlutterPowerPoint pres,
  Widget Function(Size size) builder, {
  Duration delay = const Duration(seconds: 1),
  double? pixelRatio,
  BuildContext? context,
  Size? targetSize,
}) async {
  final ctx = pres.context as FlutterPresentationContext;
  final size = targetSize ??
      Size(
        Util.ptToPixle(pres.layout.width),
        Util.ptToPixle(pres.layout.height),
      );
  final bytes = await ctx.screenshotController.captureFromWidget(
    builder(size),
    delay: delay,
    pixelRatio: pixelRatio,
    context: context,
    targetSize: size,
  );
  final image = ImageReference.fromBytes(
    bytes,
    name: 'widget',
    description: 'image created from a widget',
  );
  return image;
}
