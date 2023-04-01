import 'dart:ui' as ui;
import 'package:dart_pptx/dart_pptx.dart';

extension ImageReferenceUtils on ui.Image {
  Future<ImageReference> toImageReference(
    ui.Image image, {
    String name = 'image',
    String? description,
  }) async {
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    final buffer = bytes!.buffer;
    final data = buffer.asUint8List();
    return ImageReference.fromBytes(
      data,
      name: name,
      description: description,
    );
  }
}
