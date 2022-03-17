// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vital_top_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VitalTopResult _$VitalTopResultFromJson(Map<String, dynamic> json) {
  return VitalTopResult(
    startDate: json['startDate'] == null
        ? null
        : DateTime.parse(json['startDate'] as String),
    endDate: json['endDate'] == null
        ? null
        : DateTime.parse(json['endDate'] as String),
    showGraph: json['showGraph'] as bool,
    list: (json['list'] as List)
        ?.map((e) => e == null
            ? null
            : VitalTypeResult.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$VitalTopResultToJson(VitalTopResult instance) =>
    <String, dynamic>{
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'showGraph': instance.showGraph,
      'name': instance.name,
      'list': instance.list,
    };
