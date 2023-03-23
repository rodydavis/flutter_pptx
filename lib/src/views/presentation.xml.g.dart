// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'presentation.xml.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$SlideToJson(Slide instance) => <String, dynamic>{
      'id': instance.id,
      'rId': instance.rId,
    };

Map<String, dynamic> _$SourceToJson(Source instance) => <String, dynamic>{
      'slides': instance.slides.map((e) => e.toJson()).toList(),
      'layout': instance.layout.toJson(),
    };
