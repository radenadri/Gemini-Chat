// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) =>
    _$MessageImpl(
      owner: json['owner'] as String,
      text: json['text'] as String,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$$MessageImplToJson(_$MessageImpl instance) =>
    <String, dynamic>{
      'owner': instance.owner,
      'text': instance.text,
      'imageUrl': instance.imageUrl,
    };
