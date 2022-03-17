// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageResultModel _$PackageResultModelFromJson(Map<String, dynamic> json) {
  return PackageResultModel(
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : Package.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PackageResultModelToJson(PackageResultModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
