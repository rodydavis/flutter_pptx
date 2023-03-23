import 'package:json_annotation/json_annotation.dart';
import 'package:mustache_template/mustache_template.dart';

part 'presentation.xml.rel.g.dart';

const _source = r'''
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rId1" Target="slideMasters/slideMaster1.xml" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideMaster"/>
  <Relationship Id="rId2" Target="presProps.xml" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/presProps"/>
  <Relationship Id="rId3" Target="viewProps.xml" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/viewProps"/>
  <Relationship Id="rId4" Target="theme/theme1.xml" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/theme"/>
  <Relationship Id="rId5" Target="tableStyles.xml" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/tableStyles"/>
  {{#slides}}
  <Relationship Id="rId{{rId}}" Target="slides/slide{{order}}.xml" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slide"/>
  {{/slides}}
</Relationships>
''';

@JsonSerializable(createFactory: false)
class Slide {
  final int order;
  final int rId;

  Slide({
    required this.order,
    required this.rId,
  });

  factory Slide.fromIndex(int index) {
    return Slide(
      order: index + 1,
      rId: 5 + (index + 1),
    );
  }

  Map<String, dynamic> toJson() => _$SlideToJson(this);
}

@JsonSerializable(createFactory: false)
class Source {
  final List<Slide> slides;

  Source({
    required this.slides,
  });

  factory Source.create(int slideCount) {
    return Source(
      slides: List.generate(slideCount, (index) => Slide.fromIndex(index)),
    );
  }

  Map<String, dynamic> toJson() => _$SourceToJson(this);
}

final _template = Template(
  _source.trim(),
  name: 'presentation.xml',
  htmlEscapeValues: false,
);

String renderString(Source data) {
  return _template.renderString(data.toJson());
}
