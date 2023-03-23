// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'package:path/path.dart' as path;
import '../views/pictorial/rel.xml.dart' as rel_xml;
import '../views/pictorial/slide.xml.dart' as slide_xml;

import '../classes/coords.dart';
import '../context.dart';
import '../util.dart';
import 'slide.dart';

class Pictorial extends Slide {
  @override
  final String title;

  final String imagePath;

  Coords? coords;

  Pictorial({
    required this.title,
    required this.imagePath,
    required this.coords,
  });

  Future<Coords?> defaultCoords(PresentationContext context) async {
    try {
      final slideWidth = Util.pixleToPt(720);
      final defaultWidth = Util.pixleToPt(550);
      final size = await context.imageLibrary.getImageSize(imagePath);
      final imageWidth = Util.pixleToPt(size.width);
      final imageHeight = Util.pixleToPt(size.height);
      final newWidth = defaultWidth < imageWidth ? defaultWidth : imageWidth;
      final ratio = newWidth / imageWidth;
      final newHeight = (imageHeight * ratio).round();
      return Coords(
        x: (slideWidth / 2) - (newWidth / 2),
        y: Util.pixleToPt(120),
        cx: newWidth,
        cy: newHeight,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  FutureOr<void> save(PresentationContext context, int index, int notesIndex) async {
    coords ??= await defaultCoords(context);
    await context.imageLibrary.copyMedia(imagePath, context.archive);
    await super.save(context, index, notesIndex);
  }

  @override
  String? fileType() {
    return path.extension(imagePath).replaceAll('.', '');
  }

  String get imageName {
    return fileName.split('.').first;
  }

  String get fileName {
    return path.basename(imagePath);
  }

  @override
  FutureOr<void> saveRelXml(PresentationContext context, int index, int notesIndex) {
    final source = rel_xml.Source(
      index: index,
      notesIndex: notesIndex,
      imageName: fileName,
    );
    final result = rel_xml.renderString(source);
    final path = 'ppt/slides/_rels/slide$index.xml.rels';
    context.archive.addFile(path, result);
  }

  @override
  FutureOr<void> saveSlideXml(PresentationContext context, int index) {
    final source = slide_xml.Source(
      title: title,
      coords: coords != null
          ? slide_xml.Coords(
              x: coords!.x,
              y: coords!.y,
              cx: coords!.cx,
              cy: coords!.cy,
            )
          : null,
    );
    final result = slide_xml.renderString(source);
    final path = 'ppt/slides/slide$index.xml';
    context.archive.addFile(path, result);
  }
}
