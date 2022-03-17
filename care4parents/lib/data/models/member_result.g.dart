// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberResultModel _$MemberResultModelFromJson(Map<String, dynamic> json) {
  return MemberResultModel(
    id: json['id'] as int,
    name: json['name'] as String,
    credits: json['credits'] as String,
    relation: json['relation'] as String,
    dob: json['dob'] as String,
    gender: json['gender'] as String,
    email: json['email'] as String,
    address: json['address'] as String,
    emergency_country_code: json['emergency_country_code'] as String,
    emergency_contact_person: json['emergency_contact_person'] as String,
    emergency_contact_no: json['emergency_contact_no'] as String,
  )..phone = json['phone'] as String;
}

Map<String, dynamic> _$MemberResultModelToJson(MemberResultModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'credits': instance.credits,
      'relation': instance.relation,
      'dob': instance.dob,
      'gender': instance.gender,
      'email': instance.email,
      'address': instance.address,
      'phone': instance.phone,
      'emergency_country_code': instance.emergency_country_code,
      'emergency_contact_no': instance.emergency_contact_no,
      'emergency_contact_person': instance.emergency_contact_person,
    };
