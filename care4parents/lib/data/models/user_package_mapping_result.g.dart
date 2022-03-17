// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_package_mapping_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPackageMappingResult _$UserPackageMappingResultFromJson(
    Map<String, dynamic> json) {
  return UserPackageMappingResult(
    id: json['id'] as int,
    start_date: json['start_date'] as String,
    end_time: json['end_time'] as String,
    package: json['package'] as String,
    order: json['order'] as int,
    status: json['status'] as bool,
    family_member: json['family_member'] as int,
  );
}

Map<String, dynamic> _$UserPackageMappingResultToJson(
        UserPackageMappingResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'start_date': instance.start_date,
      'end_time': instance.end_time,
      'package': instance.package,
      'order': instance.order,
      'family_member': instance.family_member,
      'status': instance.status,
    };
