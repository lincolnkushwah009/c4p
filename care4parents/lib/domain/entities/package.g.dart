// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Package _$PackageFromJson(Map<String, dynamic> json) {
  return Package(
    id: json['id'] as int,
    name: json['name'] as String,
    status: json['status'] as bool,
    type: json['type'] as String,
    description: json['description'] as String,
    index: json['index'] as int,
    duration: json['duration'] as String,
    code: json['code'] as String,
    price: json['price'] as int,
    isSelected: json['isSelected'] as bool,
    isViewPackage: json['isViewPackage'] as bool,
  );
}

Map<String, dynamic> _$PackageToJson(Package instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'description': instance.description,
      'index': instance.index,
      'type': instance.type,
      'duration': instance.duration,
      'code': instance.code,
      'price': instance.price,
      'isSelected': instance.isSelected,
  'isViewPackage': instance.isViewPackage,
    };
