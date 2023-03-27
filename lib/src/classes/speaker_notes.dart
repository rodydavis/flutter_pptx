import 'package:json_annotation/json_annotation.dart';
import 'package:mustache_template/mustache_template.dart';

import 'slide.dart';
import 'text_value.dart';

part 'speaker_notes.g.dart';

@JsonSerializable(createFactory: false)
class SpeakerNotes {
  final int notesId;
  final TextValue text;

  SpeakerNotes({
    required this.notesId,
    required this.text,
  });

  Map<String, dynamic> toJson() => _$SpeakerNotesToJson(this);
}

final slideNotesTemplate = Template(
  slideNotes,
  partialResolver: resolvePartials,
);

const slideNotes = r'''
{{#slideNumber}}
<p:sp>
    <p:nvSpPr>
        <p:cNvPr id="{{notesId}}" name="Slide Number"/>
        <p:cNvSpPr txBox="1"/>
        <p:nvPr>
            <p:ph type="sldNum" sz="quarter" idx="2"/>
        </p:nvPr>
    </p:nvSpPr>
    <p:spPr>
        <a:xfrm>
            <a:off x="12064491" y="12700001"/>
            <a:ext cx="255017" cy="429261"/>
        </a:xfrm>
        <a:prstGeom prst="rect">
            <a:avLst/>
        </a:prstGeom>
        <a:extLst>
            <a:ext uri="{C572A759-6A51-4108-AA02-DFA0A04FC94B}">
                <ma14:wrappingTextBoxFlag val="1"
                    xmlns:ma14="http://schemas.microsoft.com/office/mac/drawingml/2011/main"/>
            </a:ext>
        </a:extLst>
    </p:spPr>
    <p:txBody>
        <a:bodyPr/>
        <a:lstStyle/>
        <a:p>
            <a:pPr/>
            <a:fld id="{86CB4B4D-7CA3-9044-876B-883B54F8677D}" type="slidenum"/>
        </a:p>
    </p:txBody>
</p:sp>
{{/slideNumber}}
''';
