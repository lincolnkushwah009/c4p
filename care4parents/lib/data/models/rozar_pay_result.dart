import 'package:json_annotation/json_annotation.dart';
part 'rozar_pay_result.g.dart';

@JsonSerializable()
class RozarPayResult {
  String id;
  int amount;

  RozarPayResult({this.id, this.amount});

  @override
  String toString() => 'RozarPay result { order id : $id, amount: $amount}';
  factory RozarPayResult.fromJson(Map<String, dynamic> json) =>
      _$RozarPayResultFromJson(json);
  Map<String, dynamic> toJson() => _$RozarPayResultToJson(this);
}
