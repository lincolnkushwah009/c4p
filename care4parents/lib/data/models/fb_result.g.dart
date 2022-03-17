// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fb_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FbResult _$FbResultFromJson(Map<String, dynamic> json) {
  return FbResult(
    id: json['id'] as String,
    first_name: json['first_name'] as String,
    last_name: json['last_name'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    picture: json['picture'],
  );
}

Map<String, dynamic> _$FbResultToJson(FbResult instance) => <String, dynamic>{
      'picture': instance.picture,
      'name': instance.name,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'email': instance.email,
      'id': instance.id,
    };
