// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$SlideQuoteToJson(SlideQuote instance) =>
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
      'attribution': instance.attribution?.toJson(),
      'quote': instance.quote?.toJson(),
      'layoutId': instance.layoutId,
      'source': instance.source,
    };
