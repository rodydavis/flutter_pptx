// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'archive.dart';
import 'image.dart';

class PresentationContext {
  final Archive archive;
  final ImageLibrary imageLibrary;

  const PresentationContext({
    required this.archive,
    required this.imageLibrary,
  });
}
