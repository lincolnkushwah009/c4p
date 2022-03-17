// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'object_common_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ObjectCommonResult _$ObjectCommonResultFromJson(Map<String, dynamic> json) {
  return ObjectCommonResult(
    data: json['data'] as Object,
    confirmation: json['confirmation'] as String,
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$ObjectCommonResultToJson(ObjectCommonResult instance) =>
    <String, dynamic>{
      'data': instance.data,
      'confirmation': instance.confirmation,
      'message': instance.message,
    };
