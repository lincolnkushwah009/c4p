// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppiontmentResultModel _$AppiontmentResultModelFromJson(
    Map<String, dynamic> json) {
  return AppiontmentResultModel(
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : AppointmentModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    limit: json['limit'] as int,
    page: json['page'] as int,
    total: json['total'] as int,
  );
}

Map<String, dynamic> _$AppiontmentResultModelToJson(
        AppiontmentResultModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'total': instance.total,
      'page': instance.page,
      'limit': instance.limit,
    };
