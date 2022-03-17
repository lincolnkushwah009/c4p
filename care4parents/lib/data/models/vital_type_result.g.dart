// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vital_type_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VitalTypeResult _$VitalTypeResultFromJson(Map<String, dynamic> json) {
  return VitalTypeResult(
    id: json['id'] as int,
    device: json['device'] as String,
    ecgfiles: json['ecgfiles'] as String,
    measureOn: json['measureOn'] == null
        ? null
        : DateTime.parse(json['measureOn'] as String),
    type: json['type'] as String,
    value: json['value'] as String,
    systolic: json['systolic'] as String,
    diastolic: json['diastolic'] as String,
  );
}

Map<String, dynamic> _$VitalTypeResultToJson(VitalTypeResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'device': instance.device,
      'ecgfiles': instance.ecgfiles,
      'measureOn': instance.measureOn?.toIso8601String(),
      'type': instance.type,
      'value': instance.value,
      'systolic': instance.systolic,
      'diastolic': instance.diastolic,
    };
