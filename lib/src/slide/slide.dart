import 'dart:async';

import '../context.dart';

abstract class Slide {
  FutureOr<void> save(PresentationContext context, int index) async {
    await saveRelXml(context, index);
    await saveSlideXml(context, index);
  }

  FutureOr<void> saveRelXml(PresentationContext context, int index);

  FutureOr<void> saveSlideXml(PresentationContext context, int index);

  String? fileType() {
    return null;
  }
}
