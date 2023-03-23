import 'package:json_annotation/json_annotation.dart';
import 'package:mustache_template/mustache_template.dart';

part 'rel.xml.g.dart';

const _source = r'''
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rId1" Target="../slideLayouts/slideLayout{{index}}.xml" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideLayout"/>
  {{#hasNotes}}
  <Relationship Id="rId2" Target="../notesSlides/notesSlide{{notesIndex}}.xml" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/notesSlide"/>
  {{/hasNotes}}
</Relationships>
''';

@JsonSerializable(createFactory: false)
class Source {
  final int index;
  final int notesIndex;
  final bool hasNotes;

  Source({
    required this.index,
    required this.notesIndex,
  }) : hasNotes = notesIndex > 0;

  Map<String, dynamic> toJson() => _$SourceToJson(this);
}

final _template = Template(
  _source.trim(),
  name: 'textual_rel.xml',
  htmlEscapeValues: false,
);

String renderString(Source data) {
  return _template.renderString(data.toJson());
}