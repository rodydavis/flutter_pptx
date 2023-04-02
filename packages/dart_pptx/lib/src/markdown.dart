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
    String? title, subtitle;
    List<ImageReference> images = [];
    ImageReference? backgroundImage;
    String? speakerNotes;
    List<String> bullets = [];

    for (final line in lines) {
      if (line.startsWith('# ')) {
        title = line.substring(2);
      } else if (line.startsWith('## ')) {
        subtitle = line.substring(3);
      } else if (line.startsWith('![')) {
        final alt = line.substring(2, line.indexOf(']'));
        final url = line.substring(line.indexOf('(') + 1, line.indexOf(')'));
        final isBackground = line.contains('{.background}');
        if (isBackground) {
          backgroundImage = ImageReference(
            path: url,
            name: alt.isEmpty ? 'Background Image' : alt,
          );
        } else {
          images.add(ImageReference(
            path: url,
            name: alt.isEmpty ? 'Image' : alt,
          ));
        }
      } else if (line.startsWith('* ') || line.startsWith('- ')) {
        bullets.add(line.substring(2));
      }
    }

    if (section.contains('<!--')) {
      final firstIdx = section.indexOf('<!--');
      final lastIdx = section.indexOf('-->');
      if (lastIdx > 0) {
        speakerNotes = section.substring(firstIdx + 4, lastIdx).trim();
      }
    }

    Slide? slide;

    if (images.length == 3) {
      // Photo 3 Up
      slide = SlidePhoto3Up(
        image1: images[0],
        image2: images[1],
        image3: images[2],
      );
    } else if (images.isNotEmpty) {
      // Image slides
      if (title != null) {
        // Title and Photo
        slide = SlideTitleAndPhoto(
          title: title.toTextValue(),
          subtitle: subtitle?.toTextValue(),
          image: images[0],
        );
      } else {
        // Photo
        slide = SlidePhoto(
          image: images[0],
        );
      }
    } else if (title != null || subtitle != null) {
      if (subtitle != null) {
        if (bullets.isNotEmpty) {
          slide = SlideTitleAndBullets(
            title: title?.toTextValue(),
            subtitle: subtitle.toTextValue(),
            bullets: bullets.map((e) => e.toTextValue()).toList(),
          );
        } else {
          slide = SlideTitleOnly(
            title: title?.toTextValue(),
            subtitle: subtitle.toTextValue(),
          );
        }
      } else {
        final isBig = title != null && title.contains('{.big}');
        if (isBig) {
          title = title.replaceAll('{.big}', '').trim();
        }
        if (isBig) {
          slide = SlideStatement(
            statement: title?.toTextValue(),
          );
        } else {
          slide = SlideTitle(
            title: title?.toTextValue(),
          );
        }
      }
    } else {
      slide = SlideBlank();
      // slide.background.color = '000000';
    }

    if (backgroundImage != null) {
      slide.background.image = backgroundImage;
    }
    if (speakerNotes != null) {
      slide.speakerNotes = TextValue.uniform(speakerNotes);
    }
    items.add(slide);
  }
  return items;
}
