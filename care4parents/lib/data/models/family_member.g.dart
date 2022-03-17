// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FamilyMember _$FamilyMemberFromJson(Map<String, dynamic> json) {
  return FamilyMember(
    id: json['id'] as int,
    email: json['email'] as String,
    name: json['name'] as String,
    credits: json['credits'] as String,
    gender: json['gender'] as String,
    relation: json['relation'] as String,
    dob: json['dob'] as String,
    phone_number: json['phone_number'] as String,
    address: json['address'] as String,
    profile_pic: json['profile_pic'] as String,
    phone: json['phone'] as String,
    emergency_contact_no: json['emergency_contact_no'] as String,
    emergency_country_code: json['emergency_country_code'] as String,
    emergency_contact_person: json['emergency_contact_person'] as String,
    user_package_mapping: json['user_package_mapping'] as int,
  );
}

Map<String, dynamic> _$FamilyMemberToJson(FamilyMember instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'credits': instance.credits,
      'email': instance.email,
      'relation': instance.relation,
      'gender': instance.gender,
      'dob': instance.dob,
      'phone_number': instance.phone_number,
      'address': instance.address,
      'emergency_country_code': instance.emergency_country_code,
      'emergency_contact_no': instance.emergency_contact_no,
      'emergency_contact_person': instance.emergency_contact_person,
      'profile_pic': instance.profile_pic,
      'phone': instance.phone,
      'user_package_mapping': instance.user_package_mapping,
    };
