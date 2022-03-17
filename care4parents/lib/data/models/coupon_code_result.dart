import 'package:json_annotation/json_annotation.dart';

import 'coupon_code.dart';
part 'coupon_code_result.g.dart';

@JsonSerializable()
class CouponCodeResult {
  bool status;
  String message;
  int amount;
  CouponCode coupon;

  CouponCodeResult({this.status, this.message, this.amount, this.coupon});

  @override
  String toString() =>
      'CouponCodeResult { status: $status, message: $message, amount:$amount, coupon:$coupon}';
  factory CouponCodeResult.fromJson(Map<String, dynamic> json) =>
      _$CouponCodeResultFromJson(json);
  Map<String, dynamic> toJson() => _$CouponCodeResultToJson(this);
}
