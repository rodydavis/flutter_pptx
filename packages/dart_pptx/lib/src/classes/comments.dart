// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:mustache_template/mustache_template.dart';

import '../template/ppt/comments/comment.xml.mustache.dart';
import 'arc.dart';
import 'base.dart';
import 'slide.dart';

part 'comments.g.dart';

@JsonSerializable(createFactory: false)
class Comments extends Base {
  String comment;
  int slideIndex;
  int x;
  int y;

  Comments({
    required this.slideIndex,
    required this.comment,
    this.x = 0,
    this.y = 0,
  });

  @override
  Map<String, dynamic> toJson() => _$CommentsToJson(this);

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
