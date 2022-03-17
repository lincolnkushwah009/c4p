import 'package:care4parents/domain/entities/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'family_member.g.dart';

@JsonSerializable()
class FamilyMember extends UserEntity {
  final int id;
  final String name;
  final String credits;

  final String email;
  final String relation;
  final String gender;

  final String dob;
  final String phone_number;
  final String address;
  final String emergency_country_code;
  final String emergency_contact_no;
  final String emergency_contact_person;
  final String profile_pic;
  final String phone;
  final int user_package_mapping;
  FamilyMember(
      {this.id,
      this.email,this.credits,
      this.name,
      this.gender,
      this.relation,
      this.dob,
      this.phone_number,
      this.address,
      this.profile_pic,
      this.phone,
      this.emergency_contact_no,
      this.emergency_country_code,
      this.emergency_contact_person,
      this.user_package_mapping});

  @override
  String toString() => '{email: $email, username: $name , phone_number: $phone_number, phone: $phone, id: $id, gender: $gender, credits: $credits }';
  factory FamilyMember.fromJson(Map<String, dynamic> json) =>
      _$FamilyMemberFromJson(json);
  Map<String, dynamic> toJson() => _$FamilyMemberToJson(this);
}
