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
    Widget child, {
    Duration delay = const Duration(seconds: 1),
    double? pixelRatio,
    BuildContext? context,
    Size? targetSize,
  }) async {
    final ctx = this.context as FlutterPresentationContext;
    final bytes = await ctx.screenshotController.captureFromWidget(
      child,
      delay: delay,
      pixelRatio: pixelRatio,
      context: context,
      targetSize: targetSize ??
          Size(
            Util.ptToPixle(layout.width),
            Util.ptToPixle(layout.height),
          ),
    );
    final image = ImageReference.fromBytes(
      bytes,
      name: 'widget',
      description: 'image created from a widget',
    );
    return addSlide(
      SlideBlank()..background.image = image,
      showSlideNumber: showSlideNumber,
    );
  }
}
