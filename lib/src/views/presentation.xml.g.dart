// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'presentation.xml.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$SlideToJson(Slide instance) => <String, dynamic>{
      'id': instance.id,
      'rId': instance.rId,
      'notes': instance.notes,
    };

Map<String, dynamic> _$NotesToJson(Notes instance) => <String, dynamic>{
      'id': instance.id,
      'rId': instance.rId,
    };

Map<String, dynamic> _$SourceToJson(Source instance) => <String, dynamic>{
      'slides': instance.slides.map((e) => e.toJson()).toList(),
      'notes': instance.notes.map((e) => e.toJson()).toList(),
      'layout': instance.layout.toJson(),
      'hasNotes': instance.hasNotes,
    };
