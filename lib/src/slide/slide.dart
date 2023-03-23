import 'dart:async';

import '../context.dart';

abstract class Slide {
  String get title;
  String notes = '';

  FutureOr<void> save(
      PresentationContext context, int index, int notesIndex) async {
    await saveRelXml(context, index, notesIndex);
    await saveSlideXml(context, index);
  }

  FutureOr<void> saveRelXml(
    PresentationContext context,
    int index,
    int notesIndex,
  );

  FutureOr<void> saveSlideXml(
    PresentationContext context,
    int index,
  );

  String? fileType() {
    return null;
  }

  void setSpeakerNotes(String notes) {
    this.notes = notes;
  }
}
