// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:mustache_template/mustache_template.dart';

import '../template/docProps/core.xml.mustache.dart';

part 'core.g.dart';

@JsonSerializable(createFactory: false)
class Core {
  String? title;
  String? subject;
  String? author;
  String? revision;
  String? date;

  Core({
    this.title,
    this.subject,
    this.author,
    this.revision,
  }) : date = DateTime.now()
            .toIso8601String()
            .replaceAll(RegExp(r'\.\d\d\dZ'), 'Z');

  Map<String, dynamic> toJson() => _$CoreToJson(this);

  @override
  String toString() {
    final source = Template(template);
    return source.renderString(toJson());
  }
}
