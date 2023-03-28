// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'title_and_photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$SlideTitleAndPhotoToJson(SlideTitleAndPhoto instance) =>
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
      'image': instance.image.toJson(),
      'title': instance.title?.toJson(),
      'author': instance.author?.toJson(),
      'subtitle': instance.subtitle?.toJson(),
      'images': instance.images.map((e) => e.toJson()).toList(),
      'layoutId': instance.layoutId,
      'imageId': instance.imageId,
      'source': instance.source,
    };
