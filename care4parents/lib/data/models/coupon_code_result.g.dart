// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_code_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponCodeResult _$CouponCodeResultFromJson(Map<String, dynamic> json) {
  return CouponCodeResult(
    status: json['status'] as bool,
    message: json['message'] as String,
    amount: json['amount'] as int,
    coupon: json['coupon'] == null
        ? null
        : CouponCode.fromJson(json['coupon'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CouponCodeResultToJson(CouponCodeResult instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'amount': instance.amount,
      'coupon': instance.coupon,
    };
