import 'package:json_annotation/json_annotation.dart';
part 'member_result.g.dart';

@JsonSerializable()
class MemberResultModel {
  int id;
  String name;
  String relation,credits;
  String dob;
  String gender;
  String email;
  String address;
  String phone;
  String emergency_country_code;
  String emergency_contact_no;
  String emergency_contact_person;

  MemberResultModel(
      {this.id,
      this.name,
        this.credits,
      this.relation,
      this.dob,
      this.gender,
      this.email,
      this.address,
      this.emergency_country_code,
      this.emergency_contact_person,
      this.emergency_contact_no});

  @override
  String toString() =>
      'Member result { id: $id, name: $name, relation: $relation, dob: $dob}';
  factory MemberResultModel.fromJson(Map<String, dynamic> json) =>
      _$MemberResultModelFromJson(json);
  Map<String, dynamic> toJson() => _$MemberResultModelToJson(this);
}
