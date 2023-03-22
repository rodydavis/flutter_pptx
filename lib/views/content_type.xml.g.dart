// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_type.xml.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$FileTypeToJson(FileType instance) => <String, dynamic>{
      'type': instance.type,
    };

Map<String, dynamic> _$SlideToJson(Slide instance) => <String, dynamic>{
      'order': instance.order,
    };

Map<String, dynamic> _$SourceToJson(Source instance) => <String, dynamic>{
      'fileTypes': instance.fileTypes.map((e) => e.toJson()).toList(),
      'slides': instance.slides.map((e) => e.toJson()).toList(),
    };
