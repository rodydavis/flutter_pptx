// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_picture_split_slide.xml.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
      'value': instance.value,
      'last': instance.last,
    };

Map<String, dynamic> _$CoordsToJson(Coords instance) => <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'cx': instance.cx,
      'cy': instance.cy,
    };

Map<String, dynamic> _$SourceToJson(Source instance) => <String, dynamic>{
      'title': instance.title,
      'content': instance.content.map((e) => e.toJson()).toList(),
      'coords': instance.coords?.toJson(),
    };
