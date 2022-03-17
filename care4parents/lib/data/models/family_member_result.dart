import 'package:care4parents/data/models/family_member.dart';
import 'package:json_annotation/json_annotation.dart';
part 'family_member_result.g.dart';

@JsonSerializable()
class FamilyMemberResult {
  String confirmation;
  String message;

  FamilyMember data;
  String token;

  FamilyMemberResult({this.confirmation, this.message, this.data, this.token});

  @override
  String toString() =>
      'FamilyMemberResult { confirmation: $confirmation, message: $message token: $token}';
  factory FamilyMemberResult.fromJson(Map<String, dynamic> json) =>
      _$FamilyMemberResultFromJson(json);
  Map<String, dynamic> toJson() => _$FamilyMemberResultToJson(this);
}
