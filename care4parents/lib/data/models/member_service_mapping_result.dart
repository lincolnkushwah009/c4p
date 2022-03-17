import 'package:json_annotation/json_annotation.dart';

part 'member_service_mapping_result.g.dart';

@JsonSerializable()
class MemberServiceMappingResult {
  int id;
  // String start_date;
  // String end_time;
  // String package;
  // int order;
  // int family_member;
  // bool status;

  MemberServiceMappingResult({
    this.id,
    // this.start_date,
    // this.end_time,
    // this.package,
    // this.order,
    // this.status,
    // this.family_member,
  });

  @override
  String toString() => 'MemberServiceMappingResult >>>>> {id: $id }';
  factory MemberServiceMappingResult.fromJson(Map<String, dynamic> json) =>
      _$MemberServiceMappingResultFromJson(json);
  Map<String, dynamic> toJson() => _$MemberServiceMappingResultToJson(this);
}
