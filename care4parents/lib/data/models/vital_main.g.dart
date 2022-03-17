// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vital_main.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VitalMain _$VitalMainFromJson(Map<String, dynamic> json) {
  return VitalMain(
    confirmation: json['confirmation'] as String,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : VitalTypeResult.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$VitalMainToJson(VitalMain instance) => <String, dynamic>{
      'confirmation': instance.confirmation,
      'data': instance.data,
    };
