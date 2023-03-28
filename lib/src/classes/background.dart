import 'package:json_annotation/json_annotation.dart';
import 'package:mustache_template/mustache_template.dart';

import 'images.dart';
import 'slide.dart';

part 'background.g.dart';

@JsonSerializable(createFactory: false)
class SlideBackground {
  String? color;
  ImageReference? image;

  SlideBackground({
    this.color,
    this.image,
  });

  Map<String, dynamic> toJson() => _$SlideBackgroundToJson(this);
}

final backgroundTemplate = Template(
  _background,
  partialResolver: resolvePartials,
);

const _background = r'''
{{#background}}
<p:bg>
    <p:bgPr>
        {{#color}}
        <a:solidFill>
            <a:srgbClr val="{{color}}"/>
        </a:solidFill>
        {{/color}}
        {{#image}}
        <a:blipFill rotWithShape="1">
            <a:blip r:embed="rId{{localRId}}"/>
            <a:srcRect l="0" t="0" r="0" b="0"/>
            <a:stretch>
                <a:fillRect/>
            </a:stretch>
        </a:blipFill>
        {{/image}}
    </p:bgPr>
</p:bg>
{{/background}}
''';
