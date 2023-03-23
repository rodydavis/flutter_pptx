// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'compression.dart';
import 'image.dart';

class PresentationContext {
  final Compression archive;
  final ImageLibrary imageLibrary;

  const PresentationContext({
    required this.archive,
    required this.imageLibrary,
  });

  factory PresentationContext.create() {
    return PresentationContext(
      archive: Compression(),
      imageLibrary: ImageLibrary(),
    );
  }
}
