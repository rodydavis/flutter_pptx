// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';
import 'package:mustache_template/mustache_template.dart';
import '../template/ppt/slides/_rels/slide.xml.rels.mustache.dart';

import 'arc.dart';
import 'base.dart';
import 'speaker_notes.dart';
import 'text_value.dart';

part 'slide.g.dart';

@JsonSerializable(createFactory: false)
abstract class Slide extends Base {
  String name;
  bool slideNumber;
  TextValue? speakerNotes;
  int layoutId = -1;
  int notesId = -1;

  Slide({
    required this.name,
    this.speakerNotes,
    this.slideNumber = false,
  });

  bool get hasNotes => speakerNotes != null;

  @override
  Map<String, dynamic> toJson() => _$SlideToJson(this);

  @JsonKey(includeToJson: false)
  String get source;

  Map<String, dynamic> generateLocalIds(Arc arc) {
    var localRId = 1;
    final localNotes = arc.getNotesForSlide(this).toList();
    final localImages = arc.getImagesForSlide(this).toList();
    for (var item in localNotes) {
      item.localRId = ++localRId;
    }
    for (var item in localImages) {
      item.localRId = ++localRId;
    }
    if (localNotes.isNotEmpty) {
      notesId = arc.notes.first.localRId!;
    }
    return {
      'notes': localNotes.map((e) => e.toJson()).toList(),
      'images': localImages.map((e) => e.toJson()).toList(),
      'layoutId': layoutId,
      'notesId': notesId,
      for (var i = 0; i < localImages.length; i++)
        'imageId${i + 1}': localImages[i].localRId,
      for (var i = 0; i < localNotes.length; i++)
        'notesId${i + 1}': localNotes[i].localRId,
    };
  }

  String renderTemplate(Arc arc) {
    final template = Template(
      source,
      partialResolver: resolvePartials,
    );
    final args = {
      ...toJson(),
      ...generateLocalIds(arc),
      ...lambdaResolver(arc, slide: this),
    };

    return template.renderString(args);
  }

  String renderRelTemplate(Arc arc) {
    generateLocalIds(arc);
    final source = Template(template);
    final args = {
      ...generateLocalIds(arc),
      ...lambdaResolver(arc, slide: this),
    };
    return source.renderString(args);
  }
}

Template? resolvePartials(String value) {
  if (value.isEmpty) return null;
  if (value == 'speaker-notes') return slideNotesTemplate;
  if (value == 'text-value') return textValueTemplate;
  return null;
}

Map<String, String Function(LambdaContext)> lambdaResolver(
  Arc arc, {
  Slide? slide,
}) {
  return {
    'new-id': (ctx) => (++arc.offset).toString(),
    'note-id': (ctx) {
      final src = ctx.renderString();
      final idx = int.parse(src);
      return arc.notes[idx].order.toString();
    },
    'image-id': (ctx) {
      final src = ctx.renderString();
      final idx = int.parse(src);
      return arc.images[idx].order.toString();
    },
  };
}
