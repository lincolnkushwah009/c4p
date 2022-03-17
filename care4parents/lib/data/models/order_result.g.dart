// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderResult _$OrderResultFromJson(Map<String, dynamic> json) {
  return OrderResult(
    id: json['id'] as int,
    package: json['package'] as String,
    family_member: json['family_member'] as int,
    quantity: json['quantity'] as int,
    user: json['user'] as int,
    name: json['name'] as String,
    order_datetime: json['order_datetime'] as String,
    phone: json['phone'] as String,
    state: json['state'] as String,
    status: json['status'] as String,
    address: json['address'] as String,
    pincode: json['pincode'] as String,
    amount: json['amount'] as int,
    promocode_id: json['promocode_id'] as int,
    promocode_name: json['promocode_name'] as String,
    discount_amount: json['discount_amount'] as int,
  );
}

Map<String, dynamic> _$OrderResultToJson(OrderResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'package': instance.package,
      'family_member': instance.family_member,
      'quantity': instance.quantity,
      'user': instance.user,
      'name': instance.name,
      'order_datetime': instance.order_datetime,
      'phone': instance.phone,
      'state': instance.state,
      'status': instance.status,
      'address': instance.address,
      'pincode': instance.pincode,
      'amount': instance.amount,
      'promocode_name': instance.promocode_name,
      'discount_amount': instance.discount_amount,
      'promocode_id': instance.promocode_id,
    };
