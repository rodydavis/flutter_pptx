import 'package:json_annotation/json_annotation.dart';
import 'package:mustache_template/mustache_template.dart';

part 'app.xml.g.dart';

const _source = r'''
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Properties xmlns="http://schemas.openxmlformats.org/officeDocument/2006/extended-properties"
            xmlns:vt="http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes">
  <TotalTime>0</TotalTime>
  <Words>43</Words>
  <Application>Microsoft Macintosh PowerPoint</Application>
  <PresentationFormat>On-screen Show (4:3)</PresentationFormat>
  <Paragraphs>15</Paragraphs>
  <Slides>{{length}}</Slides>
  <Notes>0</Notes>
  <HiddenSlides>0</HiddenSlides>
  <MMClips>0</MMClips>
  <ScaleCrop>false</ScaleCrop>
  <HeadingPairs>
    <vt:vector size="6" baseType="variant">
      <vt:variant>
        <vt:lpstr>Fonts Used</vt:lpstr>
      </vt:variant>
      <vt:variant>
        <vt:i4>2</vt:i4>
      </vt:variant>
      <vt:variant>
        <vt:lpstr>Theme</vt:lpstr>
      </vt:variant>
      <vt:variant>
        <vt:i4>1</vt:i4>
      </vt:variant>
      <vt:variant>
        <vt:lpstr>Slide Titles</vt:lpstr>
      </vt:variant>
      <vt:variant>
        <vt:i4>{{length}}</vt:i4>
      </vt:variant>
    </vt:vector>
  </HeadingPairs>
  <TitlesOfParts>
    <vt:vector size="{{vectorSize}}" baseType="lpstr">
      <vt:lpstr>Arial</vt:lpstr>
      <vt:lpstr>Calibri</vt:lpstr>
      <vt:lpstr>Office Theme</vt:lpstr>
      {{#slides}}
      <vt:lpstr>{{title}}</vt:lpstr>
      {{/slides}}
    </vt:vector>
  </TitlesOfParts>
  <Company></Company>
  <LinksUpToDate>false</LinksUpToDate>
  <SharedDoc>false</SharedDoc>
  <HyperlinksChanged>false</HyperlinksChanged>
  <AppVersion>15.0000</AppVersion>
</Properties>
''';

@JsonSerializable(createFactory: false)
class Slide {
  final String title;

  Slide({
    required this.title,
  });

  Map<String, dynamic> toJson() => _$SlideToJson(this);
}

@JsonSerializable(createFactory: false)
class Source {
  final List<Slide> slides;
  final int length;
  final int vectorSize;

  Source({
    required this.slides,
    required this.length,
    required this.vectorSize,
  });

  factory Source.slides(
    List<Slide> slides,
  ) =>
      Source(
        slides: slides,
        length: slides.length,
        vectorSize: slides.length + 3, // TODO: Validate this
      );

  Map<String, dynamic> toJson() => _$SourceToJson(this);
}

final _template = Template(
  _source.trim(),
  name: 'app.xml',
  htmlEscapeValues: false,
);

String renderString(Source data) {
  return _template.renderString(data.toJson());
}
