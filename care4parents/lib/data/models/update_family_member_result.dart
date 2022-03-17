import 'package:json_annotation/json_annotation.dart';

part 'update_family_member_result.g.dart';

@JsonSerializable()
class UpdateFamilyMemberResult {
  int id;
  // String start_date;
  // String end_time;
  // String package;
  // int order;
  // int family_member;
  // bool status;

  UpdateFamilyMemberResult({
    this.id,
    // this.start_date,
    // this.end_time,
    // this.package,
    // this.order,
    // this.status,
    // this.family_member,
  });

  @override
  String toString() => 'UpdateFamilyMemberResult >>>>> {id: $id }';
  factory UpdateFamilyMemberResult.fromJson(Map<String, dynamic> json) =>
      _$UpdateFamilyMemberResultFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateFamilyMemberResultToJson(this);
}
