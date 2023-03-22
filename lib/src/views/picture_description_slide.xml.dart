import 'package:json_annotation/json_annotation.dart';
import 'package:mustache_template/mustache_template.dart';

part 'picture_description_slide.xml.g.dart';

const _source = r'''
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<p:sld xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:p="http://schemas.openxmlformats.org/presentationml/2006/main">
  <p:cSld>
    <p:spTree>
      <p:nvGrpSpPr>
        <p:cNvPr id="1" name=""/>
        <p:cNvGrpSpPr/>
        <p:nvPr/>
      </p:nvGrpSpPr>
      <p:grpSpPr>
        <a:xfrm>
          <a:off x="0" y="0"/>
          <a:ext cx="0" cy="0"/>
          <a:chOff x="0" y="0"/>
          <a:chExt cx="0" cy="0"/>
        </a:xfrm>
      </p:grpSpPr>
      <p:sp>
        <p:nvSpPr>
          <p:cNvPr id="2" name="Title 1"/>
          <p:cNvSpPr>
            <a:spLocks noGrp="1"/>
          </p:cNvSpPr>
          <p:nvPr>
            <p:ph type="title"/>
          </p:nvPr>
        </p:nvSpPr>
        <p:spPr/>
        <p:txBody>
          <a:bodyPr/>
          <a:lstStyle/>
          <a:p>
            <a:r>
              <a:rPr lang="en-US" dirty="0" smtClean="0"/>
              <a:t>{{title}}</a:t>
            </a:r>
            <a:endParaRPr lang="en-US" dirty="0"/>
          </a:p>
        </p:txBody>
      </p:sp>
      <p:pic>
        <p:nvPicPr>
          <p:cNvPr id="5" name="Picture Placeholder 4"/>
          <p:cNvPicPr>
            <a:picLocks noGrp="1" noChangeAspect="1"/>
          </p:cNvPicPr>
          <p:nvPr>
            <p:ph type="pic" idx="1"/>
          </p:nvPr>
        </p:nvPicPr>
        <p:blipFill>
          <a:blip r:embed="rId2">
            <a:extLst>
              <a:ext uri="{28A0092B-C50C-407E-A947-70E740481C1C}">
                <a14:useLocalDpi xmlns:a14="http://schemas.microsoft.com/office/drawing/2010/main" val="0"/>
              </a:ext>
            </a:extLst>
          </a:blip>
          <a:stretch>
            <a:fillRect/>
          </a:stretch>
        </p:blipFill>
        {{#coords}}
        <p:spPr>
          <a:xfrm>
            <a:off x="{{x}}" y="{{y}}"/>
            <a:ext cx="{{cx}}" cy="{{cy}}"/>
          </a:xfrm>
          <a:prstGeom prst="rect">
            <a:avLst/>
          </a:prstGeom>
        </p:spPr>
        {{/coords}}
        {{^coords}}
        <p:spPr/>
        {{/coords}}
      </p:pic>
      <p:sp>
        <p:nvSpPr>
          <p:cNvPr id="4" name="Text Placeholder 4"/>
          <p:cNvSpPr>
            <a:spLocks noGrp="1"/>
          </p:cNvSpPr>
          <p:nvPr>
            <p:ph type="body" sz="half" idx="2"/>
          </p:nvPr>
        </p:nvSpPr>
        <p:spPr/>
        <p:txBody>
          <a:bodyPr/>
          <a:lstStyle/>
          {{#content}}
          <a:p>
            <a:r>
              <a:rPr lang="en-US" dirty="0" smtClean="0"/>
              <a:t>{{value}}</a:t>
            </a:r>
            {{#last}}
            <a:endParaRPr lang="en-US"/>
            {{/last}}
          </a:p>
          {{/content}}
        </p:txBody>
      </p:sp>

    </p:spTree>
    <p:extLst>
      <p:ext uri="{BB962C8B-B14F-4D97-AF65-F5344CB8AC3E}">
        <p14:creationId xmlns:p14="http://schemas.microsoft.com/office/powerpoint/2010/main" val="1435759726"/>
      </p:ext>
    </p:extLst>
  </p:cSld>
  <p:clrMapOvr>
    <a:masterClrMapping/>
  </p:clrMapOvr>
</p:sld>
''';

@JsonSerializable(createFactory: false)
class Content {
  final String value;
  final bool last;

  Content({
    required this.value,
    required this.last,
  });

  Map<String, dynamic> toJson() => _$ContentToJson(this);
}

@JsonSerializable(createFactory: false)
class Coords {
  final num x;
  final num y;
  final num cx;
  final num cy;

  Coords({
    required this.x,
    required this.y,
    required this.cx,
    required this.cy,
  });

  Map<String, dynamic> toJson() => _$CoordsToJson(this);
}

@JsonSerializable(createFactory: false)
class Source {
  final String title;
  final Coords? coords;
  final List<Content> content;

  Source({
    required this.title,
    required this.coords,
    required this.content,
  });

  factory Source.content({
    required String title,
    required List<String> content,
    required Coords? coords,
  }) {
    return Source(
      title: title,
      coords: coords,
      content: content
          .map((e) => Content(value: e, last: e == content.last))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => _$SourceToJson(this);
}

final _template = Template(
  _source,
  name: 'picture_description_slide.xml',
  htmlEscapeValues: false,
);

String renderString(Source data) {
  return _template.renderString(data.toJson());
}
