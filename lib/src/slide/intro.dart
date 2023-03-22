import '../archive.dart';
import '../views/textual_rel.xml.dart' as textual_rel_xml;
import '../views/intro_slide.xml.dart' as intro_slide_xml;
import 'slide.dart';

class IntroSlide extends Slide {
  final String title;
  final String subtitile;

  IntroSlide({
    required this.title,
    required this.subtitile,
  });

  @override
  save(Archive archive, int index) {
    saveRelXml(archive, index);
    saveSlideXml(archive, index);
  }

  saveRelXml(Archive archive, int index) {
    final source = textual_rel_xml.Source(
      index: index,
    );
    final result = textual_rel_xml.renderString(source);
    final path = 'ppt/slides/_rels/slide$index.xml.rels';
    archive.saveFile(path, result);
  }

  saveSlideXml(Archive archive, int index) {
    final source = intro_slide_xml.Source(
      title: title,
      subtitile: subtitile,
    );
    final result = intro_slide_xml.renderString(source);
    final path = 'ppt/slides/slide$index.xml';
    archive.saveFile(path, result);
  }
}
