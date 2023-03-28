import 'images.dart';
import 'media_slide.dart';
import 'notes.dart';
import 'slide.dart';

/// Atomic reference counter.
class Arc {
  int rId = 7;
  int id = 255;
  int offset = 150;
  List<Notes> notes = [];
  List<ImageReference> images = [];

  void init(List<Slide> slides) {
    for (var i = 0; i < slides.length; i++) {
      final slide = slides[i];
      slide.index = i;
      slide.rId = ++rId;
      if (slide.hasNotes) {
        notes.add(Notes(
          notes: slide.speakerNotes!,
          slideIndex: i,
        ));
      }
      if (slide is MediaSlide) {
        final images = slide.images;
        for (var j = 0; j < images.length; j++) {
          final image = images[j];
          final existingIdx = this.images.indexWhere((e) {
            return e.path == image.path;
          });
          if (existingIdx == -1) this.images.add(image);
        }
      }
    }
    for (var i = 0; i < notes.length; i++) {
      final item = notes[i];
      item.index = i;
      item.rId = ++rId;
    }
    for (var i = 0; i < images.length; i++) {
      final item = images[i];
      item.index = i + 1;
      item.rId = ++rId;
    }
  }

  void reset() {
    notes.clear();
    images.clear();
  }

  List<ImageReference> getImagesForSlide(Slide slide) {
    if (slide is MediaSlide) {
      return images
          .where((e) => slide.images.map((e) => e.path).contains(e.path))
          .toList();
    }
    return [];
  }

  List<Notes> getNotesForSlide(Slide slide) {
    if (slide.hasNotes) {
      return notes.where((e) => e.slideIndex == slide.index).toList();
    }
    return [];
  }
}
