// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_member_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FamilyMemberResult _$FamilyMemberResultFromJson(Map<String, dynamic> json) {
  return FamilyMemberResult(
    confirmation: json['confirmation'] as String,
    message: json['message'] as String,
    data: json['data'] == null
        ? null
        : FamilyMember.fromJson(json['data'] as Map<String, dynamic>),
    token: json['token'] as String,
  );
}

Map<String, dynamic> _$FamilyMemberResultToJson(FamilyMemberResult instance) =>
    <String, dynamic>{
      'confirmation': instance.confirmation,
      'message': instance.message,
      'data': instance.data,
      'token': instance.token,
    };
