// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_package.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPackage _$UserPackageFromJson(Map<String, dynamic> json) {
  return UserPackage(
    id: json['id'] as int,
    package: json['package'] as String,
    name: json['name'] as String,
    code: json['code'] as String,
    type:json['type'] as String,
    start_date: json['start_date'] as String,
    end_time: json['end_time'] as String,
    order: json['order'] as int,
    status: json['status'] as bool,
    family_member: json['family_member'] as int,
  );
}

Map<String, dynamic> _$UserPackageToJson(UserPackage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'package': instance.package,
      'start_date': instance.start_date,
      'end_time': instance.end_time,
      'order': instance.order,
      'status': instance.status,
      'family_member': instance.family_member,
      'name': instance.name,
      'type':instance.type,
      'code':instance.code
    };
