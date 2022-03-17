// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_add.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionAdd _$SubscriptionAddFromJson(Map<String, dynamic> json) {
  return SubscriptionAdd(
    fullName: json['fullName'] as String,
    gender: json['gender'] as String,
    currentStep: json['currentStep'] as int,
    relation: json['relation'] as String,
    dateOfBirth: json['dateOfBirth'] as String,
    email: json['email'] as String,
    address: json['address'] as String,
    phone: json['phone'] as String,
    contactPerson: json['contactPerson'] as String,
    contactNo: json['contactNo'] as String,
    package_id: json['package_id'] as int,
    package_price: json['package_price'] as int,
    package_name: json['package_name'] as String,
    package_code: json['package_code'] as String,
    package_duration: json['package_duration'] as String,
    pincode: json['pincode'] as String,
    state: json['state'] as String,
    discountAmount: json['discountAmount'] as int,
    promocode_id: json['promocode_id'] as int,
    promocode_name: json['promocode_name'] as String,
  );
}

Map<String, dynamic> _$SubscriptionAddToJson(SubscriptionAdd instance) =>
    <String, dynamic>{
      'currentStep': instance.currentStep,
      'fullName': instance.fullName,
      'gender': instance.gender,
      'relation': instance.relation,
      'dateOfBirth': instance.dateOfBirth,
      'email': instance.email,
      'address': instance.address,
      'phone': instance.phone,
      'contactPerson': instance.contactPerson,
      'contactNo': instance.contactNo,
      'package_name': instance.package_name,
      'package_code': instance.package_code,
      'package_duration': instance.package_duration,
      'package_id': instance.package_id,
      'package_price': instance.package_price,
      'pincode': instance.pincode,
      'state': instance.state,
      'discountAmount': instance.discountAmount,
      'promocode_id': instance.promocode_id,
      'promocode_name': instance.promocode_name,
    };
