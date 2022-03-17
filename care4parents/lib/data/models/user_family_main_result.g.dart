// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_family_main_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserFamilyMainResult _$UserFamilyMainResultFromJson(Map<String, dynamic> json) {
  return UserFamilyMainResult(
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : FamilyMainResult.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    page: json['page'] as int,
    total: json['total'] as int,
    limit: json['limit'] as int,
  );
}

Map<String, dynamic> _$UserFamilyMainResultToJson(
        UserFamilyMainResult instance) =>
    <String, dynamic>{
      'data': instance.data,
      'total': instance.total,
      'page': instance.page,
      'limit': instance.limit,
    };
