// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResult _$UserResultFromJson(Map<String, dynamic> json) {
  return UserResult(
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    confirmation: json['confirmation'] as String,
    message: json['message'] as String,
    jwt: json['jwt'] as String,
  );
}

Map<String, dynamic> _$UserResultToJson(UserResult instance) =>
    <String, dynamic>{
      'user': instance.user,
      'confirmation': instance.confirmation,
      'message': instance.message,
      'jwt': instance.jwt,
    };
