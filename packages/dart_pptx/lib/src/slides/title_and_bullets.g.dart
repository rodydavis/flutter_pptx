// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'title_and_bullets.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$SlideTitleAndBulletsToJson(
        SlideTitleAndBullets instance) =>
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
      'title': instance.title?.toJson(),
      'subtitle': instance.subtitle?.toJson(),
      'layoutId': instance.layoutId,
      'source': instance.source,
    };
