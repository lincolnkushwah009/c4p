import 'package:json_annotation/json_annotation.dart';

part 'user_package.g.dart';

@JsonSerializable()
class UserPackage {
  int id;
  String package;
  String start_date,name,type,code;
  String end_time;
  int order;
  bool status;
  int family_member;

  UserPackage({
    this.id,
    this.package,
    this.start_date,this.name,this.type,this.code,
    this.end_time,
    this.order,
    this.status,
    this.family_member,
  });

  @override
  String toString() => 'User Package { id: $id, package: $package}';
  factory UserPackage.fromJson(Map<String, dynamic> json) =>
      _$UserPackageFromJson(json);
  Map<String, dynamic> toJson() => _$UserPackageToJson(this);
}
