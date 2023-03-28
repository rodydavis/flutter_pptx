import 'package:json_annotation/json_annotation.dart';
import 'package:mustache_template/mustache_template.dart';

import '../template/docProps/app.xml.mustache.dart';
import 'slide.dart';

part 'app.g.dart';

@JsonSerializable(createFactory: false)
class App {
  String? company;
  int length;
  int size;
  List<Slide> slides;

  App({
    this.company,
    this.slides = const [],
  })  : length = slides.length,
        size = slides.length + 5;

  Map<String, dynamic> toJson() => _$AppToJson(this);

  @override
  String toString() {
    final source = Template(template);
    return source.renderString(toJson());
  }
}
