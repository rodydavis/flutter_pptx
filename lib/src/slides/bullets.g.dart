// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bullets.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$BulletsToJson(Bullets instance) => <String, dynamic>{
      'index': instance.index,
      'isLast': instance.isLast,
      'rId': instance.rId,
      'id': instance.id,
      'order': instance.order,
      'localRId': instance.localRId,
      'name': instance.name,
      'slideNumber': instance.slideNumber,
      'speakerNotes': instance.speakerNotes?.toJson(),
      'hasNotes': instance.hasNotes,
      'bullets': instance.bullets.map((e) => e.toJson()).toList(),
      'id1': instance.id1,
      'id2': instance.id2,
      'notesId': instance.notesId,
      'layoutId': instance.layoutId,
    };
