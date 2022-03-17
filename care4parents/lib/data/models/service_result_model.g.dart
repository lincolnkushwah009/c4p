// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceResultModel _$ServiceResultModelFromJson(Map<String, dynamic> json) {
  return ServiceResultModel(
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : Service.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    limit: json['limit'] as int,
    page: json['page'] as int,
    total: json['total'] as int,
  );
}

Map<String, dynamic> _$ServiceResultModelToJson(ServiceResultModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'total': instance.total,
      'page': instance.page,
      'limit': instance.limit,
    };
