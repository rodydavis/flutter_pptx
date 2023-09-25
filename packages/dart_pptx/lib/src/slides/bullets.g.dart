// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bullets.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$SlideBulletsToJson(SlideBullets instance) =>
    <String, dynamic>{
      'index': instance.index,
      'isLast': instance.isLast,
      'rId': instance.rId,
      'id': instance.id,
      'order': instance.order,
      'localRId': instance.localRId,
      'name': instance.name,
      'slideNumber': instance.slideNumber,
      'speakerNotes': instance.speakerNotes?.toJson(),
      'notesId': instance.notesId,
      'background': instance.background.toJson(),
      'hasNotes': instance.hasNotes,
      'bullets': instance.bullets.map((e) => e.toJson()).toList(),
      'layoutId': instance.layoutId,
      'source': instance.source,
    };
