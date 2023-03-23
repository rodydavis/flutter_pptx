// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:math';

import '../classes/coords.dart';
import '../context.dart';
import '../util.dart';
import 'pictorial.dart';
import '../views/picture_description/rels.xml.dart' as rel_xml;
import '../views/picture_description/slide.xml.dart' as slide_xml;

class DescriptionPic extends Pictorial {
  final List<String> content;

  DescriptionPic({
    required super.title,
    required super.imagePath,
    required super.coords,
    required this.content,
  });

  @override
  Future<Coords?> defaultCoords(PresentationContext context) async {
    try {
      final slideWidth = Util.pixleToPt(720);
      final defaultWidth = Util.pixleToPt(550);
      final defaultHeight = Util.pixleToPt(300);

      final size = await context.imageLibrary.getImageSize(imagePath);
      final imageWidth = Util.pixleToPt(size.width);
      final imageHeight = Util.pixleToPt(size.height);

      final cappedWidth = min(defaultWidth, imageWidth);
      final wRatio = cappedWidth / imageWidth;

      final cappedHeight = min(defaultHeight, imageHeight);
      final hRatio = cappedHeight / imageHeight;

      final ratio = min(wRatio, hRatio);

      final newWidth = (imageWidth * ratio).round();
      final newHeight = (imageHeight * ratio).round();
      return Coords(
        x: (slideWidth / 2) - (newWidth / 2),
        y: Util.pixleToPt(60),
        cx: newWidth,
        cy: newHeight,
      );
    } catch (e) {
      return null;
    }
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
    final source = slide_xml.Source.content(
      title: title,
      coords: coords != null
          ? slide_xml.Coords(
              x: coords!.x,
              y: coords!.y,
              cx: coords!.cx,
              cy: coords!.cy,
            )
          : null,
      content: content,
    );
    final result = slide_xml.renderString(source);
    final path = 'ppt/slides/slide$index.xml';
    context.archive.addFile(path, result);
  }
}
