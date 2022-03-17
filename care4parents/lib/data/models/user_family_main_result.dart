import 'package:care4parents/data/models/family_main_result.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_family_main_result.g.dart';

@JsonSerializable()
class UserFamilyMainResult {
  List<FamilyMainResult> data;
  int total;
  int page;
  int limit;

  UserFamilyMainResult({
    this.data,
    this.page,
    this.total,
    this.limit,
  });

  @override
  String toString() => 'UpdateFamilyMemberResult >>>>> {total: $total }';
  factory UserFamilyMainResult.fromJson(Map<String, dynamic> json) =>
      _$UserFamilyMainResultFromJson(json);
  Map<String, dynamic> toJson() => _$UserFamilyMainResultToJson(this);
}
