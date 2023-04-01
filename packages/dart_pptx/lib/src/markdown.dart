import 'classes.dart';
import 'slides.dart';

/// Create a presentation from a markdown string.
///
/// https://github.com/googleworkspace/md2googleslides
Future<List<Slide>> createSlidesFromMarkdown(String source) async {
  final items = <Slide>[];
  String markdown = source.trim();
  if (markdown == '---') {
    items.add(SlideBlank());
    return items;
  }
  if (!markdown.startsWith('---')) {
    markdown = '---\n$markdown';
  }
  markdown = markdown.substring(3).trim();
  final sections = markdown.split('---');
  for (final section in sections) {
    final lines = section.split('\n');
    String? title, subtitle, content;

    for (final line in lines) {
      if (line.startsWith('# ')) {
        title = line.substring(2);
      } else if (line.startsWith('## ')) {
        subtitle = line.substring(3);
      } else {
        content = line.trim();
      }
    }

    if (title != null || subtitle != null) {
      if (subtitle != null) {
        if (content != null) {
          items.add(TitleAndBullets(
            title: title?.toTextValue(),
            subtitle: subtitle.toTextValue(),
            bullets: [content.toTextValue()],
          ));
        } else {
          items.add(SlideTitleOnly(
            title: title?.toTextValue(),
            subtitle: subtitle.toTextValue(),
          ));
        }
      } else {
        final isBig = title != null && title.contains('{.big}');
        if (isBig) {
          title = title.replaceAll('{.big}', '').trim();
        }
        if (content != null) {
          if (isBig) {
            items.add(SlideBigFact(
              fact: title?.toTextLine(),
              information: content.toTextValue(),
            ));
          } else {
            items.add(SlideTitleOnly(
              title: title?.toTextValue(),
              subtitle: content.toTextValue(),
            ));
          }
        } else {
          if (isBig) {
            items.add(SlideStatement(
              statement: title?.toTextValue(),
            ));
          } else {
            items.add(SlideTitle(
              title: title?.toTextValue(),
            ));
          }
        }
      }
    } else if (content != null) {
      items.add(SlideSection(
        section: content.toTextValue(),
      ));
    } else {
      items.add(SlideBlank());
    }
  }
  return items;
}
