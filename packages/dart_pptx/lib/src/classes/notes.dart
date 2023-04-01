// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:mustache_template/mustache_template.dart';

import '../template/ppt/notesSlides/notesSlide.xml.mustache.dart';
import 'arc.dart';
import 'base.dart';
import 'slide.dart';
import 'text_value.dart';

part 'notes.g.dart';

@JsonSerializable(createFactory: false)
class Notes extends Base {
  TextValue notes;
  int slideIndex;

  Notes({
    required this.slideIndex,
    required this.notes,
  });

  @override
  Map<String, dynamic> toJson() => _$NotesToJson(this);

  String renderTemplate(Arc arc) {
    final source = Template(
      template,
      partialResolver: resolvePartials,
    );
    final args = {
      ...toJson(),
      ...lambdaResolver(arc),
    };
    return source.renderString(args);
  }
}
