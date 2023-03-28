// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slide.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$SlideToJson(Slide instance) => <String, dynamic>{
      'index': instance.index,
      'isLast': instance.isLast,
      'rId': instance.rId,
      'id': instance.id,
      'order': instance.order,
      'localRId': instance.localRId,
      'name': instance.name,
      'slideNumber': instance.slideNumber,
      'speakerNotes': instance.speakerNotes?.toJson(),
      'layoutId': instance.layoutId,
      'notesId': instance.notesId,
      'hasNotes': instance.hasNotes,
      'imageRefs':
          instance.imageRefs.map((k, e) => MapEntry(k.toString(), e?.toJson())),
    };
