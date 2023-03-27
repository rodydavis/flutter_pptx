import 'package:json_annotation/json_annotation.dart';
import 'package:mustache_template/mustache_template.dart';

import 'slide.dart';

part 'text_value.g.dart';

@JsonSerializable(createFactory: false)
class TextItem {
  final String value;
  bool isBold, isItalic, isUnderline, isStrikeThrough;

  bool get isStylized => isBold || isItalic || isUnderline || isStrikeThrough;

  TextItem(
    this.value, {
    this.isBold = false,
    this.isItalic = false,
    this.isUnderline = false,
    this.isStrikeThrough = false,
  });

  Map<String, dynamic> toJson() => _$TextItemToJson(this);
}

@JsonSerializable(createFactory: false)
class TextValue {
  final List<TextItem> values;

  TextValue({
    required this.values,
  });

  factory TextValue.normal(
    String? value, {
    bool isBold = false,
    bool isItalic = false,
    bool isUnderline = false,
    bool isStrikeThrough = false,
  }) {
    return TextValue(
      values: [
        if (value != null)
          TextItem(
            value,
            isBold: isBold,
            isItalic: isItalic,
            isUnderline: isUnderline,
            isStrikeThrough: isStrikeThrough,
          ),
      ],
    );
  }

  factory TextValue.list(List<TextItem>? values) {
    return TextValue(values: values ?? []);
  }

  Map<String, dynamic> toJson() => _$TextValueToJson(this);
}

final textValueTemplate = Template(
  normalString,
  partialResolver: resolvePartials,
);

const normalString = r'''
{{#values}}
<a:r>
    {{#isStylized}}
    <a:rPr
        {{#isBold}}b="1"{{/isBold}}
        {{#isItalic}}i="1"{{/isItalic}}
        {{#isUnderline}}u="sng"{{/isUnderline}}
        {{#isStrikeThrough}}strike="sngStrike"{{/isStrikeThrough}}
    />
    {{/isStylized}}
    <a:t>{{value}}</a:t>
</a:r>
{{/values}}
''';
