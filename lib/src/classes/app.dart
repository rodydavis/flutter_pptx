import 'package:json_annotation/json_annotation.dart';
import 'package:mustache_template/mustache_template.dart';

import '../template/docProps/app.xml.mustache.dart';

part 'app.g.dart';

@JsonSerializable(createFactory: false)
class App {
  final String? company;
  final int length;
  final int size;
  final List<String> slideTitles;

  App({
    this.company,
    this.slideTitles = const [],
  })  : length = slideTitles.length,
        size = slideTitles.length + 5;

  Map<String, dynamic> toJson() => _$AppToJson(this);

  @override
  String toString() {
    final source = Template(template);
    return source.renderString(toJson());
  }
}
