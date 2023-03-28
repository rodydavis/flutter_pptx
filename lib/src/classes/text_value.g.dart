// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$TextItemToJson(TextItem instance) => <String, dynamic>{
      'value': instance.value,
      'isBold': instance.isBold,
      'isItalic': instance.isItalic,
      'isUnderline': instance.isUnderline,
      'isStrikeThrough': instance.isStrikeThrough,
      'isStylized': instance.isStylized,
    };

Map<String, dynamic> _$TextValueLineToJson(TextValueLine instance) =>
    <String, dynamic>{
      'values': instance.values.map((e) => e.toJson()).toList(),
    };

Map<String, dynamic> _$TextValueToJson(TextValue instance) => <String, dynamic>{
      'lines': instance.lines.map((e) => e.toJson()).toList(),
    };
