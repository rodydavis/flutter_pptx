// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import '../classes/coords.dart';
import '../context.dart';
import '../util.dart';
import '../views/text_picture_split_rel.xml.dart' as rel_xml;
import '../views/text_picture_split_slide.xml.dart' as slide_xml;
import 'pictorial.dart';

class TextPicSplit extends Pictorial {
  final List<String> content;

  TextPicSplit({
    required super.title,
    required super.imagePath,
    required super.coords,
    required this.content,
  });

  @override
  Future<Coords?> defaultCoords(PresentationContext context) async {
    try {
      final startX = Util.pixleToPt(360);
      final defaultWidth = Util.pixleToPt(300);

      final size = await context.imageLibrary.getImageSize(imagePath);
      final imageWidth = Util.pixleToPt(size.width);
      final imageHeight = Util.pixleToPt(size.height);
      final newWidth = defaultWidth < imageWidth ? defaultWidth : imageWidth;
      final ratio = newWidth / imageWidth;
      final newHeight = (imageHeight * ratio).round();
      return Coords(
        x: startX,
        y: Util.pixleToPt(120),
        cx: newWidth,
        cy: newHeight,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  FutureOr<void> saveRelXml(PresentationContext context, int index) {
    final source = rel_xml.Source(
      index: index,
      imageName: imageName,
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
