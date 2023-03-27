import 'slide.dart';
import 'images.dart';

abstract class MediaSlide extends Slide {
  MediaSlide({
    required super.name,
    super.speakerNotes,
    super.slideNumber,
  });

  List<ImageReference> get images;
}
