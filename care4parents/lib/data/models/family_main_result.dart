import 'package:care4parents/data/models/family_member.dart';
import 'package:care4parents/data/models/user_package.dart';
import 'package:care4parents/domain/entities/package.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'family_main_result.g.dart';

@JsonSerializable()
class FamilyMainResult extends Equatable {
  final int id;
  final bool status;
  final int family_member_id;
  final int user_id;
  final FamilyMember family_member;
  final UserPackage package;
  final List<UserPackage> packageData;
  FamilyMainResult(
      {this.id,
      this.status,
      this.family_member_id,
      this.user_id,
      this.family_member,
      this.package,this.packageData});
  @override
  bool operator ==(Object other) => other is FamilyMainResult && other.id == id;
  @override
  String toString() =>
      'FamilyMainResult { id: $id, family_member_id: $family_member_id user_id: $user_id, family_member: $family_member}';
  factory FamilyMainResult.fromJson(Map<String, dynamic> json) =>
      _$FamilyMainResultFromJson(json);
  Map<String, dynamic> toJson() => _$FamilyMainResultToJson(this);

  @override
  List<Object> get props =>
      [id, family_member_id, family_member, package, user_id, status];
}
