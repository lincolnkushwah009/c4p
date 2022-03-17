import 'package:json_annotation/json_annotation.dart';
part 'common_result.g.dart';

@JsonSerializable()
class CommonResult {
  String data;
  String confirmation;

  CommonResult({this.data, this.confirmation});

  @override
  String toString() =>
      'Common result { data: $data, confirmation: $confirmation}';
  factory CommonResult.fromJson(Map<String, dynamic> json) =>
      _$CommonResultFromJson(json);
  Map<String, dynamic> toJson() => _$CommonResultToJson(this);
}
