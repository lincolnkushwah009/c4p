import 'package:care4parents/data/models/member_result.dart';
import 'package:json_annotation/json_annotation.dart';
part 'member_main_result.g.dart';

@JsonSerializable()
class MemberMainResult {
  MemberResultModel data;
  String confirmation;

  MemberMainResult({this.data, this.confirmation});

  @override
  String toString() =>
      'Memeber main result { data: $data, confirmation: $confirmation}';
  factory MemberMainResult.fromJson(Map<String, dynamic> json) =>
      _$MemberMainResultFromJson(json);
  Map<String, dynamic> toJson() => _$MemberMainResultToJson(this);
}
