import 'package:collection/collection.dart';

import 'comments.dart';
import 'images.dart';
import 'notes.dart';
import 'slide.dart';

/// Atomic reference counter.
class Arc {
  int rId = 7;
  int id = 255;
  int offset = 150;
  List<Notes> notes = [];
  List<ImageReference> images = [];
  List<Comments> comments = [];

  void init(List<Slide> slides) {
    for (var i = 0; i < slides.length; i++) {
      final slide = slides[i];
      slide.index = i;
      slide.id = ++id;
      slide.rId = ++rId;
      if (slide.hasNotes) {
        notes.add(Notes(
          notes: slide.speakerNotes!,
          slideIndex: i,
        ));
      }
      if (slide.background.image != null) {
        // Fix for background image being duplicated
        ImageReference image = slide.background.image!;
        final existingIdx = this.images.indexWhere((e) => e == image);
        if (existingIdx > 0) {
          image = this.images[existingIdx];
          slide.background.image = image;
        }
        slide.imageRefs[0] = image;
      }
      final images = slide.imageRefs.values.toList();
      for (var j = 0; j < images.length; j++) {
        final image = images[j];
        if (image != null) {
          final existingIdx = this.images.indexWhere((e) => e == image);
          if (existingIdx == -1) {
            this.images.add(image);
          }
        }
      }
    }
    for (var i = 0; i < notes.length; i++) {
      final item = notes[i];
      item.index = i;
      item.id = ++id;
      item.rId = ++rId;
    }
    for (var i = 0; i < images.length; i++) {
      final item = images[i];
      item.index = i + 1;
      item.id = ++id;
      item.rId = ++rId;
    }
  }

  void reset() {
    notes.clear();
    images.clear();
  }

  List<ImageReference> getImagesForSlide(Slide slide) {
    final related = slide.imageRefs.values.whereNotNull().toList();
    final results = <ImageReference>[];
    for (final item in related) {
      final match = images.firstWhereOrNull((e) => e == item);
      if (match != null) results.add(match);
    }
    return results;
  }

  List<Notes> getNotesForSlide(Slide slide) {
    if (slide.hasNotes) {
      return notes.where((e) => e.slideIndex == slide.index).toList();
    }
    return [];
  }
}
