// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_main_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderMainResult _$OrderMainResultFromJson(Map<String, dynamic> json) {
  return OrderMainResult(
    data: json['data'] == null
        ? null
        : OrderResult.fromJson(json['data'] as Map<String, dynamic>),
    confirmation: json['confirmation'] as String,
  );
}

Map<String, dynamic> _$OrderMainResultToJson(OrderMainResult instance) =>
    <String, dynamic>{
      'data': instance.data,
      'confirmation': instance.confirmation,
    };
