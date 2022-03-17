import 'package:json_annotation/json_annotation.dart';
part 'coupon_code.g.dart';

@JsonSerializable()
class CouponCode {
  int id;
  String name;

  CouponCode({this.id, this.name});

  @override
  String toString() => 'OCouponCode { id: $id, name: $name}';
  factory CouponCode.fromJson(Map<String, dynamic> json) =>
      _$CouponCodeFromJson(json);
  Map<String, dynamic> toJson() => _$CouponCodeToJson(this);
}
