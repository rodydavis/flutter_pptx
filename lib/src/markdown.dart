import 'classes/slide.dart';
import 'classes/text_value.dart';
import 'slides/big_fact.dart';
import 'slides/blank.dart';
import 'slides/section.dart';
import 'slides/statement.dart';
import 'slides/title.dart';
import 'slides/title_and_bullets.dart';
import 'slides/title_only.dart';

/// Create a presentation from a markdown string.
/// 
/// https://github.com/googleworkspace/md2googleslides
List<Slide> createSlidesFromMarkdown(String source) {
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
        if (content != null) {
          if (isBig) {
            items.add(SlideBigFact(
              fact: title.toTextLine(),
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
            title = title.replaceAll('{.big}', '').trim();
            items.add(SlideStatement(
              statement: title.toTextValue(),
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
