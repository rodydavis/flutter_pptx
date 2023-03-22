// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_picture_split_slide.xml.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$SlideToJson(Slide instance) => <String, dynamic>{
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
      'slides': instance.slides.map((e) => e.toJson()).toList(),
      'coords': instance.coords?.toJson(),
    };
