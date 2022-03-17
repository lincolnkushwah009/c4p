import 'package:care4parents/data/models/order_result.dart';
import 'package:json_annotation/json_annotation.dart';
part 'order_main_result.g.dart';

@JsonSerializable()
class OrderMainResult {
  OrderResult data;
  String confirmation;

  OrderMainResult({this.data, this.confirmation});

  @override
  String toString() =>
      'Order main result { data: $data, confirmation: $confirmation}';
  factory OrderMainResult.fromJson(Map<String, dynamic> json) =>
      _$OrderMainResultFromJson(json);
  Map<String, dynamic> toJson() => _$OrderMainResultToJson(this);
}
