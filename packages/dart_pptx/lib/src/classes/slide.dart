// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mustache_template/mustache_template.dart';
import '../template/ppt/slides/_rels/slide.xml.rels.mustache.dart';

import 'arc.dart';
import 'background.dart';
import 'base.dart';
import 'images.dart';
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
  var background = SlideBackground();

  Slide({
    required this.name,
    this.speakerNotes,
    this.slideNumber = false,
  });

  bool get hasNotes => speakerNotes != null;

  @JsonKey(includeToJson: false)
  late Map<int, ImageReference?> imageRefs = {0: background.image};

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
    final data = {
      'notes': localNotes.map((e) => e.toJson()).toList(),
      'images': localImages.map((e) => e.toJson()).toList(),
      'comments': [],
      'layoutId': layoutId,
      'notesId': notesId,
    };
    for (final entry in imageRefs.entries) {
      final image = entry.value;
      final match = localImages.firstWhereOrNull((e) => e.path == image?.path);
      data['imageId${entry.key}'] = match?.localRId ?? 1;
    }
    for (var i = 0; i < localNotes.length; i++) {
      data['notesId${i + 1}'] = localNotes[i].localRId!;
    }
    return data;
  }

  Map<String, dynamic> toMap(Arc arc) {
    final local = generateLocalIds(arc);
    final data = {
      ...toJson(),
      ...local,
      ...lambdaResolver(arc, slide: this),
    };
    // Replace null with false
    return replaceNulls(data);
  }

  Map<String, dynamic> replaceNulls(Map<String, dynamic> data) {
    final newMap = <String, dynamic>{};
    for (final entry in data.entries) {
      if (entry.value == null) {
        newMap[entry.key] = false;
      } else if (entry.value is Map<String, dynamic>) {
        newMap[entry.key] = replaceNulls(entry.value as Map<String, dynamic>);
      } else {
        newMap[entry.key] = entry.value;
      }
    }
    return newMap;
  }

  String renderTemplate(Arc arc) {
    final template = Template(
      source,
      partialResolver: resolvePartials,
    );
    return template.renderString(toMap(arc));
  }

  String renderRelTemplate(Arc arc) {
    final source = Template(template);
    return source.renderString(toMap(arc));
  }
}

Template? resolvePartials(String value) {
  if (value.isEmpty) return null;
  if (value == 'slide-background') return backgroundTemplate;
  if (value == 'speaker-notes') return slideNotesTemplate;
  if (value == 'text-value') return multiLineTemplate;
  if (value == 'text-line') return singleLineTemplate;
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
