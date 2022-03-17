// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceModel _$ServiceModelFromJson(Map<String, dynamic> json) {
  return ServiceModel(
    id: json['id'] as int,
    service: json['service'] as String,
    remarks: json['remarks'] as String,
    bookingdate: json['bookingdate'] as String,
    startbookingdate: json['startbookingdate'] as String,
    specialist_type: json['specialist_type'] as String,
    timerange: json['timerange'] as String,
    endbookingdate: json['endbookingdate'] as String,
  );
}

Map<String, dynamic> _$ServiceModelToJson(ServiceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'service': instance.service,
      'remarks': instance.remarks,
      'bookingdate': instance.bookingdate,
      'startbookingdate': instance.startbookingdate,
      'endbookingdate': instance.endbookingdate,
      'specialist_type': instance.specialist_type,
      'timerange': instance.timerange,
    };
