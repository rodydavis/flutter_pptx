import 'package:json_annotation/json_annotation.dart';
import 'package:mustache_template/mustache_template.dart';

part 'rel.xml.g.dart';

const _source = r'''
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
    <Relationship Id="rId11" Target="../slideLayouts/slideLayout11.xml" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideLayout"/>
    <Relationship Id="rId12" Target="../theme/theme1.xml" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/theme"/>
    <Relationship Id="rId1" Target="../slideLayouts/slideLayout1.xml" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideLayout"/>
    <Relationship Id="rId2" Target="../slideLayouts/slideLayout2.xml" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideLayout"/>
    <Relationship Id="rId3" Target="../slideLayouts/slideLayout3.xml" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideLayout"/>
    <Relationship Id="rId4" Target="../slideLayouts/slideLayout4.xml" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideLayout"/>
    <Relationship Id="rId5" Target="../slideLayouts/slideLayout5.xml" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideLayout"/>
    <Relationship Id="rId6" Target="../slideLayouts/slideLayout6.xml" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideLayout"/>
    <Relationship Id="rId7" Target="../slideLayouts/slideLayout7.xml" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideLayout"/>
    <Relationship Id="rId8" Target="../slideLayouts/slideLayout8.xml" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideLayout"/>
    <Relationship Id="rId9" Target="../slideLayouts/slideLayout9.xml" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideLayout"/>
    <Relationship Id="rId10" Target="../slideLayouts/slideLayout10.xml" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideLayout"/>
</Relationships>
''';

@JsonSerializable(createFactory: false)
class Source {
  final int index;
  final int slideIndex;

  Source({
    required this.index,
    required this.slideIndex,
  });

  Map<String, dynamic> toJson() => _$SourceToJson(this);
}

final _template = Template(
  _source.trim(),
  name: 'slide_master_rel.xml',
  htmlEscapeValues: false,
);

String renderString(Source data) {
  return _template.renderString(data.toJson());
}
