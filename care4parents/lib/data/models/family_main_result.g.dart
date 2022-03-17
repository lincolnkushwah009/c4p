// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_main_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FamilyMainResult _$FamilyMainResultFromJson(Map<String, dynamic> json) {
  return FamilyMainResult(
    id: json['id'] as int,
    status: json['status'] as bool,
    family_member_id: json['family_member_id'] as int,
    user_id: json['user_id'] as int,
    family_member: json['family_member'] == null
        ? null
        : FamilyMember.fromJson(json['family_member'] as Map<String, dynamic>),

    packageData: (json['packageData'] as List)
        ?.map((e) => e == null
        ? null
        : UserPackage.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    package: json['package'] == null
        ? null
        : UserPackage.fromJson(json['package'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FamilyMainResultToJson(FamilyMainResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'family_member_id': instance.family_member_id,
      'user_id': instance.user_id,
      'family_member': instance.family_member,
      'package': instance.package,
      'packageData': instance.packageData,
    };
