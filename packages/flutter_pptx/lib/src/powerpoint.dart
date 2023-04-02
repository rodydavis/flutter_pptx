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
    final ctx = this.context as FlutterPresentationContext;
    final size = targetSize ??
        Size(
          Util.ptToPixle(layout.width),
          Util.ptToPixle(layout.height),
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
    return addSlide(SlideBlank()..background.image = image);
  }
}
