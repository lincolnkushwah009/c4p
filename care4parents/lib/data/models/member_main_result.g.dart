// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_main_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberMainResult _$MemberMainResultFromJson(Map<String, dynamic> json) {
  return MemberMainResult(
    data: json['data'] == null
        ? null
        : MemberResultModel.fromJson(json['data'] as Map<String, dynamic>),
    confirmation: json['confirmation'] as String,
  );
}

Map<String, dynamic> _$MemberMainResultToJson(MemberMainResult instance) =>
    <String, dynamic>{
      'data': instance.data,
      'confirmation': instance.confirmation,
    };
