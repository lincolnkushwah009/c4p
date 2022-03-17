// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileResponse _$UserProfileResponseFromJson(Map<String, dynamic> json) {
  return UserProfileResponse(
    docurl: json['docurl'] as String,
    confirmation: json['confirmation'] as String,
    originalimage: json['originalimage'] as String,
  );
}

Map<String, dynamic> _$UserProfileResponseToJson(
        UserProfileResponse instance) =>
    <String, dynamic>{
      'confirmation': instance.confirmation,
      'originalimage': instance.originalimage,
      'docurl': instance.docurl,
    };
