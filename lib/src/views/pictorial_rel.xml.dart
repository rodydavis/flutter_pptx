import 'package:json_annotation/json_annotation.dart';
import 'package:mustache_template/mustache_template.dart';

part 'pictorial_rel.xml.g.dart';

const _source = r'''
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rId1" Target="../slideLayouts/slideLayout{{index}}.xml" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideLayout"/>
  <Relationship Id="rId2" Target="../media/{{imageName}}" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/image"/>
</Relationships>
''';

@JsonSerializable(createFactory: false)
class Source {
  final int index;
  final String imageName;

  Source({
    required this.index,
    required this.imageName,
  });

  Map<String, dynamic> toJson() => _$SourceToJson(this);
}

final _template = Template(
  _source.trim(),
  name: 'pictorial_rel.xml',
  htmlEscapeValues: false,
);

String renderString(Source data) {
  return _template.renderString(data.toJson());
}
