import 'package:json_annotation/json_annotation.dart';
import 'package:mustache_template/mustache_template.dart';

part 'text_value.g.dart';

@JsonSerializable(createFactory: false)
class TextValue {
  final String? value;

  TextValue({
    this.value,
  });

  factory TextValue.normal(String? value) {
    return TextValue(value: value);
  }

  Map<String, dynamic> toJson() => _$TextValueToJson(this);
}

final textValueTemplate = Template(normalString);

const normalString = r'''
{{#value}}
<a:r>
    <a:t>{{value}}</a:t>
</a:r>
{{/value}}
''';
