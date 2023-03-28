// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'title_and_bullets.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$TitleAndBulletsToJson(TitleAndBullets instance) =>
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
      'hasNotes': instance.hasNotes,
      'imageRefs':
          instance.imageRefs.map((k, e) => MapEntry(k.toString(), e?.toJson())),
      'bullets': instance.bullets.map((e) => e.toJson()).toList(),
      'title': instance.title?.toJson(),
      'author': instance.author?.toJson(),
      'subtitle': instance.subtitle?.toJson(),
      'layoutId': instance.layoutId,
      'source': instance.source,
    };
