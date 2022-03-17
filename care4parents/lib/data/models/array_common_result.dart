import 'package:json_annotation/json_annotation.dart';
part 'array_common_result.g.dart';

@JsonSerializable()
class ArrayCommonResult {
  List<dynamic> data;
  String confirmation;

  ArrayCommonResult({this.data, this.confirmation});

  @override
  String toString() =>
      'Array Common result { data: $data, confirmation: $confirmation}';
  factory ArrayCommonResult.fromJson(Map<String, dynamic> json) =>
      _$ArrayCommonResultFromJson(json);
  Map<String, dynamic> toJson() => _$ArrayCommonResultToJson(this);
}
